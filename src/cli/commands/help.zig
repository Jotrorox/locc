const std = @import("std");

const Command = @import("../command.zig").Command;

fn run(_: []const []const u8) anyerror!void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("LOCC - A better Lines of Code Counter\n", .{});
    try stdout.print("Version: 0.2.0\n\n", .{});
    try stdout.print("Usage: locc [OPTIONS] [PATH]\n\n", .{});
    try stdout.print("Options:\n", .{});
    try stdout.print("  -h, --help      Show this help message\n", .{});
    try stdout.print("  -f, --file-mode Show file counts instead of line counts\n", .{});
    try stdout.print("\nFor more information, visit: https://github.com/Jotrorox/locc\n", .{});
}

pub const HelpCommand = Command{
    .cli_args = .{
        .long = "help",
        .short = "h",
    },
    .name = "help",
    .description = "Shows help information about the program.",
    .run = run,
};
