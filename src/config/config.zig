const std = @import("std");

const config_json = @embedFile("config.json");

pub const ConfigError = error{
    MissingIgnoredPaths,
    InvalidJson,
    OutOfMemory,
    ConfigFileError,
    XdgError,
};

pub const FileType = struct {
    display_name: []const u8,
    file_extensions: []const []const u8,
};

pub const Config = struct {
    ignored_paths: [][]const u8,
    file_types: []FileType,

    pub fn init(allocator: std.mem.Allocator) ConfigError!Config {
        return initWithUserConfig(allocator);
    }

    pub fn deinit(self: *Config, allocator: std.mem.Allocator) void {
        // Free ignored_paths
        for (self.ignored_paths) |path| {
            allocator.free(path);
        }
        allocator.free(self.ignored_paths);

        // Free file_types and their extensions
        for (self.file_types) |file_type| {
            allocator.free(file_type.display_name);
            for (file_type.file_extensions) |ext| {
                allocator.free(ext);
            }
            allocator.free(file_type.file_extensions);
        }
        allocator.free(self.file_types);
    }

    pub fn shouldIgnore(self: *const Config, path: []const u8) bool {
        for (self.ignored_paths) |ignored_path| {
            if (std.mem.eql(u8, path, ignored_path)) {
                return true;
            }
        }
        return false;
    }

    pub fn shouldIgnorePattern(self: *const Config, path: []const u8) bool {
        for (self.ignored_paths) |ignored_path| {
            if (std.mem.eql(u8, path, ignored_path)) return true;

            if (std.mem.indexOf(u8, ignored_path, "*")) |_| {
                if (matchesWildcard(path, ignored_path)) return true;
            }
        }
        return false;
    }

    pub fn getIgnoredPathsCount(self: *const Config) usize {
        return self.ignored_paths.len;
    }
};

fn initWithUserConfig(allocator: std.mem.Allocator) ConfigError!Config {
    // Get XDG config directory
    const xdg_config_dir = getXdgConfigDir(allocator) catch {
        std.debug.print("Warning: Could not get XDG config directory, using embedded config\n", .{});
        return loadConfig(allocator);
    };
    defer allocator.free(xdg_config_dir);

    // Create locc config directory path
    const locc_config_dir = std.fs.path.join(allocator, &[_][]const u8{ xdg_config_dir, "locc" }) catch {
        std.debug.print("Warning: Could not create config directory path, using embedded config\n", .{});
        return loadConfig(allocator);
    };
    defer allocator.free(locc_config_dir);

    // Create user config file path
    const user_config_path = std.fs.path.join(allocator, &[_][]const u8{ locc_config_dir, "config.json" }) catch {
        std.debug.print("Warning: Could not create config file path, using embedded config\n", .{});
        return loadConfig(allocator);
    };
    defer allocator.free(user_config_path);

    // Check if user config exists, if not create it
    if (!std.fs.path.isAbsolute(user_config_path)) {
        std.debug.print("Error: Invalid config path\n", .{});
        return loadConfig(allocator);
    }

    std.fs.accessAbsolute(user_config_path, .{}) catch {
        // Config doesn't exist, create it
        createUserConfig(locc_config_dir, user_config_path) catch {
            std.debug.print("Warning: Could not create user config file, using embedded config\n", .{});
            return loadConfig(allocator);
        };
    };

    // Load user config
    return loadUserConfig(allocator, user_config_path) catch {
        std.debug.print("Warning: Could not load user config, using embedded config\n", .{});
        return loadConfig(allocator);
    };
}

fn getXdgConfigDir(allocator: std.mem.Allocator) ConfigError![]u8 {
    // Try XDG_CONFIG_HOME first
    if (std.posix.getenv("XDG_CONFIG_HOME")) |xdg_config_home| {
        return allocator.dupe(u8, xdg_config_home) catch ConfigError.OutOfMemory;
    }

    // Fallback to $HOME/.config
    const home = std.posix.getenv("HOME") orelse return ConfigError.XdgError;
    return std.fs.path.join(allocator, &[_][]const u8{ home, ".config" }) catch ConfigError.OutOfMemory;
}

fn createUserConfig(config_dir: []const u8, config_path: []const u8) ConfigError!void {
    // Create the directory if it doesn't exist
    std.fs.makeDirAbsolute(config_dir) catch |err| switch (err) {
        error.PathAlreadyExists => {}, // Directory already exists, that's fine
        else => return ConfigError.ConfigFileError,
    };

    // Write the embedded config to the user config file
    const file = std.fs.createFileAbsolute(config_path, .{}) catch {
        return ConfigError.ConfigFileError;
    };
    defer file.close();

    file.writeAll(config_json) catch {
        return ConfigError.ConfigFileError;
    };

    std.debug.print("Created user config file at: {s}\n", .{config_path});
}

fn loadConfig(allocator: std.mem.Allocator) ConfigError!Config {
    return parseConfigFromJson(allocator, config_json);
}

fn loadUserConfig(allocator: std.mem.Allocator, config_path: []const u8) ConfigError!Config {
    const file = std.fs.openFileAbsolute(config_path, .{}) catch {
        return ConfigError.ConfigFileError;
    };
    defer file.close();

    const file_size = file.getEndPos() catch return ConfigError.ConfigFileError;
    const contents = allocator.alloc(u8, file_size) catch return ConfigError.OutOfMemory;
    defer allocator.free(contents);

    _ = file.readAll(contents) catch return ConfigError.ConfigFileError;

    return parseConfigFromJson(allocator, contents);
}

fn parseConfigFromJson(allocator: std.mem.Allocator, json_content: []const u8) ConfigError!Config {
    const parsed = std.json.parseFromSlice(std.json.Value, allocator, json_content, .{}) catch {
        std.debug.print("Error: Failed to parse config JSON\n", .{});
        return ConfigError.InvalidJson;
    };
    defer parsed.deinit();

    const root = parsed.value;
    const ignored_paths_json = root.object.get("ignored_paths") orelse {
        std.debug.print("Error: 'ignored_paths' field missing from config\n", .{});
        return ConfigError.MissingIgnoredPaths;
    };

    var ignored_paths = std.ArrayList([]const u8).init(allocator);
    errdefer {
        for (ignored_paths.items) |path| {
            allocator.free(path);
        }
        ignored_paths.deinit();
    }

    for (ignored_paths_json.array.items) |item| {
        const path = allocator.dupe(u8, item.string) catch {
            std.debug.print("Error: Failed to allocate memory for path: {s}\n", .{item.string});
            return ConfigError.OutOfMemory;
        };
        ignored_paths.append(path) catch {
            allocator.free(path);
            return ConfigError.OutOfMemory;
        };
    }

    const file_types_json = root.object.get("file_types") orelse {
        std.debug.print("Warning: 'file_types' field missing from config, using empty list\n", .{});
        return Config{
            .ignored_paths = ignored_paths.toOwnedSlice() catch return ConfigError.OutOfMemory,
            .file_types = &[_]FileType{},
        };
    };

    var file_types = std.ArrayList(FileType).init(allocator);
    errdefer {
        for (file_types.items) |file_type| {
            allocator.free(file_type.display_name);
            for (file_type.file_extensions) |ext| {
                allocator.free(ext);
            }
            allocator.free(file_type.file_extensions);
        }
        file_types.deinit();
    }

    // Iterate over the object entries instead of array items
    var iterator = file_types_json.object.iterator();
    while (iterator.next()) |entry| {
        const display_name_src = entry.key_ptr.*;
        const extensions_json = entry.value_ptr.*;

        if (extensions_json != .array) {
            std.debug.print("Error: file extensions for '{s}' should be an array\n", .{display_name_src});
            return ConfigError.InvalidJson;
        }

        // Duplicate the display name since JSON memory will be freed
        const display_name = allocator.dupe(u8, display_name_src) catch {
            std.debug.print("Error: Failed to allocate memory for display name: {s}\n", .{display_name_src});
            return ConfigError.OutOfMemory;
        };
        errdefer allocator.free(display_name);

        var extensions = std.ArrayList([]const u8).init(allocator);
        errdefer {
            for (extensions.items) |ext| {
                allocator.free(ext);
            }
            extensions.deinit();
        }

        for (extensions_json.array.items) |ext_item| {
            const ext = allocator.dupe(u8, ext_item.string) catch {
                std.debug.print("Error: Failed to allocate memory for file extension: {s}\n", .{ext_item.string});
                return ConfigError.OutOfMemory;
            };
            extensions.append(ext) catch {
                allocator.free(ext);
                return ConfigError.OutOfMemory;
            };
        }

        const file_type = FileType{
            .display_name = display_name,
            .file_extensions = extensions.toOwnedSlice() catch return ConfigError.OutOfMemory,
        };
        file_types.append(file_type) catch return ConfigError.OutOfMemory;
    }

    const config = Config{
        .ignored_paths = ignored_paths.toOwnedSlice() catch return ConfigError.OutOfMemory,
        .file_types = file_types.toOwnedSlice() catch return ConfigError.OutOfMemory,
    };

    return config;
}

fn matchesWildcard(text: []const u8, pattern: []const u8) bool {
    if (std.mem.indexOf(u8, pattern, "*")) |star_pos| {
        const prefix = pattern[0..star_pos];
        const suffix = pattern[star_pos + 1 ..];

        // Check if text starts with prefix and ends with suffix
        if (text.len < prefix.len + suffix.len) return false;

        return std.mem.startsWith(u8, text, prefix) and
            std.mem.endsWith(u8, text, suffix);
    }
    return std.mem.eql(u8, text, pattern);
}

pub const ProgramAuthor = struct {
    name: []const u8,
    email: []const u8,

    pub fn init(name: []const u8, email: []const u8) ProgramAuthor {
        return ProgramAuthor{
            .name = name,
            .email = email,
        };
    }
};

pub const ProgramConfig = struct {
    name: []const u8,
    version: []const u8,
    author: []const ProgramAuthor,

    pub fn init(name: []const u8, version: []const u8, author: []const ProgramAuthor) ProgramConfig {
        return ProgramConfig{
            .name = name,
            .version = version,
            .author = author,
        };
    }
};
