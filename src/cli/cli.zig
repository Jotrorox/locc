const config = @import("config.zig");
const parser = @import("parser.zig");
const command = @import("command.zig");
const programConfig = @import("../config/config.zig");
const std = @import("std");

pub const CLI = struct {
    pConfig: programConfig.ProgramConfig,
    commands: []const command.Command,

    pub fn parse(cli: CLI, allocator: std.mem.Allocator) anyerror!config.CliConfig {
        var p = try parser.parseProcess(allocator, .{});
        defer p.deinit();

        var c = config.CliConfig.initDefault(p.nextValue() orelse @panic("No Programname provided"));
        var args_list = std.ArrayList([]const u8).init(allocator);

        while (p.next()) |token| {
            switch (token) {
                .flag => |flag| {
                    if (flag.isLong("help") or flag.isShort("h")) {
                        c.help = true;
                        return c;
                    } else if (flag.isLong("file-mode") or flag.isShort("f")) {
                        c.file_mode = true;
                    }

                    for (cli.commands) |cmd| {
                        if (flag.isLong(cmd.cli_args.long) or flag.isShort(cmd.cli_args.short)) {
                            try cmd.run(&[_][]const u8{cmd.name});
                            return c;
                        }
                    }
                },
                .arg => |arg| {
                    try args_list.append(arg);
                },
                .unexpected_value => @panic("Unexpected value in command line arguments"),
            }
        }

        // Convert ArrayList to owned slice
        c.args = try args_list.toOwnedSlice();
        return c;
    }
};
