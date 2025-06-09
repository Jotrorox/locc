const std = @import("std");
const StringArrayHashMap = std.StringArrayHashMap;

const config_module = @import("config/config.zig");
const Config = config_module.Config;
const ConfigError = config_module.ConfigError;
const ProgramConfig = config_module.ProgramConfig;
const ProgramAuthor = config_module.ProgramAuthor;

const cli = @import("./cli/cli.zig");
const Command = @import("./cli/command.zig").Command;
const HelpCommand = @import("./cli/commands/help.zig").HelpCommand;

const ParsedDirectory = struct {
    directory: std.fs.Dir,
    file_count: StringArrayHashMap(u32),
    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator, path: []const u8) !ParsedDirectory {
        const dir = try std.fs.cwd().openDir(path, .{ .iterate = true });
        return ParsedDirectory{
            .directory = dir,
            .file_count = StringArrayHashMap(u32).init(allocator),
            .allocator = allocator,
        };
    }

    pub fn initD(allocator: std.mem.Allocator, dir: std.fs.Dir) !ParsedDirectory {
        return ParsedDirectory{
            .directory = dir,
            .file_count = StringArrayHashMap(u32).init(allocator),
            .allocator = allocator,
        };
    }

    pub fn initM(allocator: std.mem.Allocator, path: []const u8, file_count: StringArrayHashMap(u32)) ParsedDirectory {
        const dir = try std.fs.cwd().openDir(path, .{ .iterate = true });
        return ParsedDirectory{
            .directory = dir,
            .file_count = file_count,
            .allocator = allocator,
        };
    }

    pub fn initDM(allocator: std.mem.Allocator, dir: std.fs.Dir, file_count: StringArrayHashMap(u32)) ParsedDirectory {
        return ParsedDirectory{
            .directory = dir,
            .file_count = file_count,
            .allocator = allocator,
        };
    }

    pub fn deinit(self: *ParsedDirectory) void {
        self.file_count.deinit();
        self.directory.close();
    }

    pub fn merge(self: *ParsedDirectory, other: ParsedDirectory) !void {
        for (other.file_count.keys()) |key| {
            const count = other.file_count.get(key) orelse @panic("Key not found");
            const existing_count = self.file_count.get(key) orelse 0;
            try self.file_count.put(key, existing_count + count);
        }
    }

    pub fn mergeHashMap(self: *ParsedDirectory, other: StringArrayHashMap(u32)) !void {
        for (other.keys()) |key| {
            const count = other.get(key) orelse @panic("Key not found");
            const existing_count = self.file_count.get(key) orelse 0;
            try self.file_count.put(key, existing_count + count);
        }
    }

    pub fn getFileCount(self: *const ParsedDirectory, path: []const u8) u32 {
        return self.file_count.get(path) orelse 0;
    }
};

fn parseDir(allocator: std.mem.Allocator, path: []const u8, config: *const Config) !ParsedDirectory {
    var dir = try std.fs.cwd().openDir(path, .{ .iterate = true });

    var tmpMap = StringArrayHashMap(u32).init(allocator);

    if (config.shouldIgnore(path)) {
        std.debug.print("Ignoring directory: {s}\n", .{path});
        return ParsedDirectory.initD(allocator, dir);
    }

    var iterator = dir.iterate();
    while (try iterator.next()) |entry| {
        switch (entry.kind) {
            .file => {
                if (config.shouldIgnorePattern(entry.name)) continue;

                const file_ending = std.fs.path.extension(entry.name);
                if (file_ending.len == 0) continue;

                const file_ext = if (file_ending.len > 1 and file_ending[0] == '.') file_ending[1..] else file_ending;
                for (config.file_types) |file_type| {
                    for (file_type.file_extensions) |ext| {
                        if (std.mem.eql(u8, file_ext, ext)) {
                            const count = tmpMap.get(ext) orelse 0;
                            try tmpMap.put(ext, count + 1);
                            break;
                        }
                    }
                }
            },
            .directory => {
                if (config.shouldIgnore(entry.name)) continue;

                const new_path = try std.fmt.allocPrint(allocator, "{s}/{s}", .{ path, entry.name });
                defer allocator.free(new_path);
                var subDir = try parseDir(allocator, new_path, config);
                defer subDir.deinit();

                for (subDir.file_count.keys()) |key| {
                    const count = subDir.file_count.get(key) orelse 0;
                    const existing_count = tmpMap.get(key) orelse 0;
                    try tmpMap.put(key, existing_count + count);
                }
            },

            .block_device => continue,
            .character_device => continue,
            .door => continue,
            .event_port => continue,
            .named_pipe => continue,
            .sym_link => continue,
            .unix_domain_socket => continue,
            .whiteout => continue,
            .unknown => continue,
        }
    }

    return ParsedDirectory.initDM(allocator, dir, tmpMap);
}

const CurrentProgramConfig = ProgramConfig.init("LOCC", "0.2.0", &[_]ProgramAuthor{
    ProgramAuthor.init("Johannes (Jotrorox) Müller", "mail@jotrorox.com"),
});

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    // Load configuration
    var config = Config.init(allocator) catch |err| {
        switch (err) {
            ConfigError.MissingIgnoredPaths => std.debug.print("Error: Missing 'ignored_paths' in config\n", .{}),
            ConfigError.InvalidJson => std.debug.print("Error: Invalid JSON in config file\n", .{}),
            ConfigError.OutOfMemory => std.debug.print("Error: Out of memory while loading config\n", .{}),
        }
        return;
    };
    defer config.deinit(allocator);

    const commands = [_]Command{
        HelpCommand,
    };

    const cli_config = cli.CLI{
        .pConfig = CurrentProgramConfig,
        .commands = &commands,
    };
    const cli_data = try cli_config.parse();

    if (cli_data.help) {
        return try HelpCommand.run(&[_][]const u8{});
    }

    var parsedDir = try parseDir(allocator, ".", &config);
    defer parsedDir.deinit();

    std.debug.print("File counts:\n", .{});
    for (config.file_types) |file_type| {
        var total_count: u32 = 0;
        for (file_type.file_extensions) |ext| {
            const count = parsedDir.getFileCount(ext);
            total_count += count;
        }
        if (total_count > 0) {
            std.debug.print("{s}: {d}\n", .{ file_type.display_name, total_count });
        }
    }
}
