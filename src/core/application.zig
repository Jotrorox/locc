const std = @import("std");
const config_module = @import("../config/config.zig");
const Config = config_module.Config;
const ConfigError = config_module.ConfigError;
const ProgramConfig = config_module.ProgramConfig;
const ProgramAuthor = config_module.ProgramAuthor;

const cli = @import("../cli/cli.zig");
const Command = @import("../cli/command.zig").Command;
const HelpCommand = @import("../cli/commands/help.zig").HelpCommand;

const directory_parser = @import("../parser/directory_parser.zig");
const display = @import("../display/output.zig");

pub const Application = struct {
    allocator: std.mem.Allocator,
    config: Config,
    program_config: ProgramConfig,
    cli_args: ?[]const []const u8,

    const APP_VERSION = "0.2.0";

    pub fn init(allocator: std.mem.Allocator) !Application {
        const program_config = ProgramConfig.init("LOCC", APP_VERSION, &[_]ProgramAuthor{
            ProgramAuthor.init("Johannes (Jotrorox) Müller", "mail@jotrorox.com"),
        });

        const config = Config.init(allocator) catch |err| {
            switch (err) {
                ConfigError.MissingIgnoredPaths => {
                    std.debug.print("Error: Missing 'ignored_paths' in config\n", .{});
                    return err;
                },
                ConfigError.InvalidJson => {
                    std.debug.print("Error: Invalid JSON in config file\n", .{});
                    return err;
                },
                ConfigError.OutOfMemory => {
                    std.debug.print("Error: Out of memory while loading config\n", .{});
                    return err;
                },
                ConfigError.ConfigFileError => {
                    std.debug.print("Error: Failed to read config file\n", .{});
                    return err;
                },
                ConfigError.XdgError => {
                    std.debug.print("Error: Could not determine XDG config directory\n", .{});
                    return err;
                },
            }
        };

        return Application{
            .allocator = allocator,
            .config = config,
            .program_config = program_config,
            .cli_args = null,
        };
    }

    pub fn deinit(self: *Application) void {
        self.config.deinit(self.allocator);
        if (self.cli_args) |args| {
            self.allocator.free(args);
        }
    }

    pub fn run(self: *Application) !void {
        const commands = [_]Command{
            HelpCommand,
        };

        const cli_config = cli.CLI{
            .pConfig = self.program_config,
            .commands = &commands,
        };

        const cli_data = try cli_config.parse(self.allocator);
        self.cli_args = cli_data.args;

        if (cli_data.help) {
            return try display.displayHelp();
        }

        // Parse the directory (default to current directory)
        const target_path = if (cli_data.args.len > 0) cli_data.args[0] else ".";

        var parsed_dir = try directory_parser.parseDirectory(self.allocator, target_path, &self.config);
        defer parsed_dir.deinit();

        // Display results
        display.displayResults(&self.config, &parsed_dir, cli_data.file_mode);
    }
};
