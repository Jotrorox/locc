const std = @import("std");

const config_module = @import("config/config.zig");
const Config = config_module.Config;
const ConfigError = config_module.ConfigError;
const ProgramConfig = config_module.ProgramConfig;
const ProgramAuthor = config_module.ProgramAuthor;

const cli = @import("./cli/cli.zig");
const Command = @import("./cli/command.zig").Command;
const HelpCommand = @import("./cli/commands/help.zig").HelpCommand;

fn parseDir(allocator: std.mem.Allocator, path: []const u8, config: *const Config) !void {
    var dir = try std.fs.cwd().openDir(path, .{ .iterate = true });
    defer dir.close();

    var iterator = dir.iterate();
    while (try iterator.next()) |entry| {
        switch (entry.kind) {
            .file => {
                if (config.shouldIgnorePattern(entry.name)) continue;

                std.debug.print("Processing file: {s}\n", .{entry.name});
            },
            .directory => {
                if (config.shouldIgnore(entry.name)) continue;

                const new_path = try std.fmt.allocPrint(allocator, "{s}/{s}", .{ path, entry.name });
                defer allocator.free(new_path);
                try parseDir(allocator, new_path, config);
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
}

const CurrentProgramConfig = ProgramConfig.init("LOCC", "0.2.0", &[_]ProgramAuthor{ProgramAuthor.init("Johannes (Jotrorox) Müller", "mail@jotrorox.com")});

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

    try parseDir(allocator, ".", &config);
}
