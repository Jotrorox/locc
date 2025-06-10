const std = @import("std");
const Config = @import("../config/config.zig").Config;
const ParsedDirectory = @import("../parser/directory_parser.zig").ParsedDirectory;

pub fn displayResults(config: *const Config, parsed_dir: *const ParsedDirectory, file_mode: bool) void {
    if (file_mode) {
        displayLineMode(config, parsed_dir);
    } else {
        displayFileMode(config, parsed_dir);
    }
}

fn displayFileMode(config: *const Config, parsed_dir: *const ParsedDirectory) void {
    const stdout = std.io.getStdOut().writer();
    stdout.print("File counts:\n", .{}) catch return;

    var total_files: u32 = 0;
    for (config.file_types) |file_type| {
        var type_count: u32 = 0;
        for (file_type.file_extensions) |ext| {
            const count = parsed_dir.getFileCount(ext);
            type_count += count;
        }
        if (type_count > 0) {
            stdout.print("{s}: {d}\n", .{ file_type.display_name, type_count }) catch return;
            total_files += type_count;
        }
    }

    if (total_files > 0) {
        stdout.print("\nTotal files: {d}\n", .{total_files}) catch return;
    }
}

fn displayLineMode(config: *const Config, parsed_dir: *const ParsedDirectory) void {
    const stdout = std.io.getStdOut().writer();
    stdout.print("Lines of code:\n", .{}) catch return;

    var total_lines: u32 = 0;
    var total_files: u32 = 0;

    for (config.file_types) |file_type| {
        var type_line_count: u32 = 0;
        var type_file_count: u32 = 0;

        for (file_type.file_extensions) |ext| {
            const lines = parsed_dir.getLineCount(ext);
            const files = parsed_dir.getFileCount(ext);
            type_line_count += lines;
            type_file_count += files;
        }

        if (type_line_count > 0) {
            stdout.print("{s:<30} {d:>3} files {d:>6} lines\n", .{ file_type.display_name, type_file_count, type_line_count }) catch return;
            total_lines += type_line_count;
            total_files += type_file_count;
        }
    }

    if (total_lines > 0) {
        stdout.print("──────────────────────────────────────\n", .{}) catch return;
        stdout.print("{s:<30} {d:>3} files {d:>6} lines\n", .{ "Total", total_files, total_lines }) catch return;
    }
}

pub fn displayHelp() !void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("LOCC - A better Lines of Code Counter\n", .{});
    try stdout.print("Version: 0.2.0\n\n", .{});
    try stdout.print("Usage: locc [OPTIONS] [PATH]\n\n", .{});
    try stdout.print("Options:\n", .{});
    try stdout.print("  -h, --help      Show this help message\n", .{});
    try stdout.print("  -f, --file-mode Show line counts instead of file counts\n", .{});
    try stdout.print("\nFor more information, visit: https://github.com/Jotrorox/locc\n", .{});
}
