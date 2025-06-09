const std = @import("std");

const config_json = @embedFile("config.json");

pub const ConfigError = error{
    MissingIgnoredPaths,
    InvalidJson,
    OutOfMemory,
};

pub const FileType = struct {
    display_name: []const u8,
    file_extensions: []const []const u8,
};

pub const Config = struct {
    ignored_paths: [][]const u8,
    file_types: []FileType,

    pub fn init(allocator: std.mem.Allocator) ConfigError!Config {
        return loadConfig(allocator) catch |err| switch (err) {
            error.OutOfMemory => ConfigError.OutOfMemory,
            error.MissingIgnoredPaths => ConfigError.MissingIgnoredPaths,
            else => ConfigError.InvalidJson,
        };
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

fn loadConfig(allocator: std.mem.Allocator) !Config {
    const parsed = std.json.parseFromSlice(std.json.Value, allocator, config_json, .{}) catch {
        std.debug.print("Error: Failed to parse embedded config.json\n", .{});
        return error.InvalidJson;
    };
    defer parsed.deinit();

    const root = parsed.value;
    const ignored_paths_json = root.object.get("ignored_paths") orelse {
        std.debug.print("Error: 'ignored_paths' field missing from config.json\n", .{});
        return error.MissingIgnoredPaths;
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
            return error.OutOfMemory;
        };
        ignored_paths.append(path) catch {
            allocator.free(path);
            return error.OutOfMemory;
        };
    }

    const file_types_json = root.object.get("file_types") orelse {
        std.debug.print("Warning: 'file_types' field missing from config.json, using empty list\n", .{});
        return Config{
            .ignored_paths = ignored_paths.toOwnedSlice() catch return error.OutOfMemory,
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
            return error.InvalidJson;
        }

        // Duplicate the display name since JSON memory will be freed
        const display_name = allocator.dupe(u8, display_name_src) catch {
            std.debug.print("Error: Failed to allocate memory for display name: {s}\n", .{display_name_src});
            return error.OutOfMemory;
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
                return error.OutOfMemory;
            };
            extensions.append(ext) catch {
                allocator.free(ext);
                return error.OutOfMemory;
            };
        }

        const file_type = FileType{
            .display_name = display_name,
            .file_extensions = extensions.toOwnedSlice() catch return error.OutOfMemory,
        };
        file_types.append(file_type) catch return error.OutOfMemory;
    }
    
    const config = Config{
        .ignored_paths = ignored_paths.toOwnedSlice() catch return error.OutOfMemory,
        .file_types = file_types.toOwnedSlice() catch return error.OutOfMemory,
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
