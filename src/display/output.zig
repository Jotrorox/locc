const std = @import("std");
const Config = @import("../config/config.zig").Config;
const ParsedDirectory = @import("../parser/directory_parser.zig").ParsedDirectory;

// ANSI color codes for pretty output
const Colors = struct {
    const reset = "\x1b[0m";
    const bold = "\x1b[1m";
    const dim = "\x1b[2m";
    const italic = "\x1b[3m";
    const underline = "\x1b[4m";

    // Foreground colors
    const black = "\x1b[30m";
    const red = "\x1b[31m";
    const green = "\x1b[32m";
    const yellow = "\x1b[33m";
    const blue = "\x1b[34m";
    const magenta = "\x1b[35m";
    const cyan = "\x1b[36m";
    const white = "\x1b[37m";

    // Bright colors
    const bright_black = "\x1b[90m";
    const bright_red = "\x1b[91m";
    const bright_green = "\x1b[92m";
    const bright_yellow = "\x1b[93m";
    const bright_blue = "\x1b[94m";
    const bright_magenta = "\x1b[95m";
    const bright_cyan = "\x1b[96m";
    const bright_white = "\x1b[97m";

    // Background colors
    const bg_black = "\x1b[40m";
    const bg_red = "\x1b[41m";
    const bg_green = "\x1b[42m";
    const bg_yellow = "\x1b[43m";
    const bg_blue = "\x1b[44m";
    const bg_magenta = "\x1b[45m";
    const bg_cyan = "\x1b[46m";
    const bg_white = "\x1b[47m";
};

// Unicode symbols and icons
const Symbols = struct {
    const file_icon = "📄";
    const folder_icon = "📁";
    const code_icon = "💻";
    const stats_icon = "📊";
    const total_icon = "🔢";
    const check_mark = "✓";
    const arrow_right = "→";
    const bullet = "•";
    const line_horizontal = "─";
    const line_vertical = "│";
    const corner_top_left = "┌";
    const corner_top_right = "┐";
    const corner_bottom_left = "└";
    const corner_bottom_right = "┘";
    const junction_left = "├";
    const junction_right = "┤";
    const junction_top = "┬";
    const junction_bottom = "┴";
    const cross = "┼";
};

pub fn displayResults(config: *const Config, parsed_dir: *const ParsedDirectory, file_mode: bool) void {
    const stdout = std.io.getStdOut().writer();

    // Display header
    displayHeader(stdout) catch return;

    if (file_mode) {
        displayFileMode(config, parsed_dir);
    } else {
        displayLineMode(config, parsed_dir);
    }
}

fn displayHeader(writer: anytype) !void {
    try writer.print("\n", .{});
    try writer.print("{s}{s}┌─────────────────────────────────────────────────────────────┐{s}\n", .{ Colors.bright_cyan, Colors.bold, Colors.reset });
    try writer.print("{s}{s}│  {s}{s} LOCC - Lines of Code Counter {s}{s}                     │{s}\n", .{ Colors.bright_cyan, Colors.bold, Symbols.code_icon, Colors.bright_white, Colors.bright_cyan, Colors.bold, Colors.reset });
    try writer.print("{s}{s}└─────────────────────────────────────────────────────────────┘{s}\n", .{ Colors.bright_cyan, Colors.bold, Colors.reset });
    try writer.print("\n", .{});
}

fn displayFileMode(config: *const Config, parsed_dir: *const ParsedDirectory) void {
    const stdout = std.io.getStdOut().writer();

    // Section header
    stdout.print("{s}{s}{s} File Statistics{s}\n", .{ Symbols.file_icon, Colors.bright_yellow, Colors.bold, Colors.reset }) catch return;
    stdout.print("{s}{s}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━{s}\n", .{ Colors.bright_black, Colors.dim, Colors.reset }) catch return;

    var total_files: u32 = 0;
    var has_files = false;

    for (config.file_types) |file_type| {
        var type_count: u32 = 0;
        for (file_type.file_extensions) |ext| {
            const count = parsed_dir.getFileCount(ext);
            type_count += count;
        }
        if (type_count > 0) {
            has_files = true;
            const color = getFileTypeColor(file_type.display_name);
            stdout.print("  {s}{s}●{s} {s}{s:<20}{s} {s}{s}{d:>6}{s} files\n", .{ color, Colors.bold, Colors.reset, Colors.bright_white, file_type.display_name, Colors.reset, color, Colors.bold, type_count, Colors.reset }) catch return;
            total_files += type_count;
        }
    }

    if (has_files) {
        stdout.print("\n{s}{s}┌─────────────────────────────────────┐{s}\n", .{ Colors.bright_green, Colors.bold, Colors.reset }) catch return;
        stdout.print("{s}{s}│  {s} Total Files: {s}{d:>6}{s}           │{s}\n", .{ Colors.bright_green, Colors.bold, Symbols.total_icon, Colors.bright_white, total_files, Colors.bright_green, Colors.reset }) catch return;
        stdout.print("{s}{s}└─────────────────────────────────────┘{s}\n", .{ Colors.bright_green, Colors.bold, Colors.reset }) catch return;
    } else {
        stdout.print("  {s}{s}No files found matching configured patterns{s}\n", .{ Colors.bright_black, Colors.dim, Colors.reset }) catch return;
    }

    stdout.print("\n", .{}) catch return;
}

fn displayLineMode(config: *const Config, parsed_dir: *const ParsedDirectory) void {
    const stdout = std.io.getStdOut().writer();

    // Section header
    stdout.print("{s}{s}{s} Code Statistics{s}\n", .{ Symbols.stats_icon, Colors.bright_green, Colors.bold, Colors.reset }) catch return;
    stdout.print("{s}{s}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━{s}\n", .{ Colors.bright_black, Colors.dim, Colors.reset }) catch return;

    var total_lines: u32 = 0;
    var total_files: u32 = 0;
    var has_code = false;

    // Create a temporary allocator for formatting numbers
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

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
            has_code = true;
            const color = getFileTypeColor(file_type.display_name);

            // Format numbers with commas - with simpler error handling
            const formatted_lines = formatNumber(allocator, type_line_count) catch blk: {
                var buf: [32]u8 = undefined;
                const simple = std.fmt.bufPrint(buf[0..], "{d}", .{type_line_count}) catch "0";
                break :blk allocator.dupe(u8, simple) catch "0";
            };
            defer if (!std.mem.eql(u8, formatted_lines, "0")) allocator.free(formatted_lines);

            const formatted_files = formatNumber(allocator, type_file_count) catch blk: {
                var buf: [32]u8 = undefined;
                const simple = std.fmt.bufPrint(buf[0..], "{d}", .{type_file_count}) catch "0";
                break :blk allocator.dupe(u8, simple) catch "0";
            };
            defer if (!std.mem.eql(u8, formatted_files, "0")) allocator.free(formatted_files);

            stdout.print("  {s}{s}●{s} {s}{s:<18}{s} {s}{s}{s:>8}{s} lines  {s}{s}{s:>6}{s} files\n", .{ color, Colors.bold, Colors.reset, Colors.bright_white, file_type.display_name, Colors.reset, color, Colors.bold, formatted_lines, Colors.reset, Colors.bright_black, Colors.dim, formatted_files, Colors.reset }) catch return;

            total_lines += type_line_count;
            total_files += type_file_count;
        }
    }

    if (has_code) {
        // Format totals - with simpler error handling
        const formatted_total_lines = formatNumber(allocator, total_lines) catch blk: {
            var buf: [32]u8 = undefined;
            const simple = std.fmt.bufPrint(buf[0..], "{d}", .{total_lines}) catch "0";
            break :blk allocator.dupe(u8, simple) catch "0";
        };
        defer if (!std.mem.eql(u8, formatted_total_lines, "0")) allocator.free(formatted_total_lines);

        const formatted_total_files = formatNumber(allocator, total_files) catch blk: {
            var buf: [32]u8 = undefined;
            const simple = std.fmt.bufPrint(buf[0..], "{d}", .{total_files}) catch "0";
            break :blk allocator.dupe(u8, simple) catch "0";
        };
        defer if (!std.mem.eql(u8, formatted_total_files, "0")) allocator.free(formatted_total_files);

        stdout.print("\n{s}{s}┌─────────────────────────────────────────────────────────┐{s}\n", .{ Colors.bright_magenta, Colors.bold, Colors.reset }) catch return;
        stdout.print("{s}{s}│  {s} Total: {s}{s:>8}{s} lines in {s}{s:>6}{s} files        │{s}\n", .{ Colors.bright_magenta, Colors.bold, Symbols.total_icon, Colors.bright_white, formatted_total_lines, Colors.bright_magenta, Colors.bright_white, formatted_total_files, Colors.bright_magenta, Colors.reset }) catch return;
        stdout.print("{s}{s}└─────────────────────────────────────────────────────────┘{s}\n", .{ Colors.bright_magenta, Colors.bold, Colors.reset }) catch return;
    } else {
        stdout.print("  {s}{s}No code files found matching configured patterns{s}\n", .{ Colors.bright_black, Colors.dim, Colors.reset }) catch return;
    }

    stdout.print("\n", .{}) catch return;
}

pub fn displayHelp() !void {
    const stdout = std.io.getStdOut().writer();

    // Header with logo
    try stdout.print("\n", .{});
    try stdout.print("{s}{s}┌─────────────────────────────────────────────────────────────┐{s}\n", .{ Colors.bright_cyan, Colors.bold, Colors.reset });
    try stdout.print("{s}{s}│  {s}{s} LOCC - A Better Lines of Code Counter {s}{s}              │{s}\n", .{ Colors.bright_cyan, Colors.bold, Symbols.code_icon, Colors.bright_white, Colors.bright_cyan, Colors.bold, Colors.reset });
    try stdout.print("{s}{s}│  {s}{s}Version 0.2.0{s}{s}                                         │{s}\n", .{ Colors.bright_cyan, Colors.bold, Colors.bright_black, Colors.dim, Colors.bright_cyan, Colors.bold, Colors.reset });
    try stdout.print("{s}{s}└─────────────────────────────────────────────────────────────┘{s}\n", .{ Colors.bright_cyan, Colors.bold, Colors.reset });

    try stdout.print("\n", .{});

    // Usage section
    try stdout.print("{s}{s}{s} Usage{s}\n", .{ Symbols.arrow_right, Colors.bright_yellow, Colors.bold, Colors.reset });
    try stdout.print("{s}{s}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━{s}\n", .{ Colors.bright_black, Colors.dim, Colors.reset });
    try stdout.print("  {s}{s}locc{s} {s}[OPTIONS] [PATH]{s}\n", .{ Colors.bright_green, Colors.bold, Colors.reset, Colors.bright_black, Colors.reset });
    try stdout.print("\n", .{});

    // Options section
    try stdout.print("{s}{s}{s} Options{s}\n", .{ Symbols.bullet, Colors.bright_magenta, Colors.bold, Colors.reset });
    try stdout.print("{s}{s}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━{s}\n", .{ Colors.bright_black, Colors.dim, Colors.reset });
    try stdout.print("  {s}{s}-h{s}, {s}{s}--help{s}      {s}Show this help message{s}\n", .{ Colors.bright_green, Colors.bold, Colors.reset, Colors.bright_green, Colors.bold, Colors.reset, Colors.bright_white, Colors.reset });
    try stdout.print("  {s}{s}-f{s}, {s}{s}--file-mode{s} {s}Show file counts instead of line counts{s}\n", .{ Colors.bright_green, Colors.bold, Colors.reset, Colors.bright_green, Colors.bold, Colors.reset, Colors.bright_white, Colors.reset });

    try stdout.print("\n", .{});

    // Examples section
    try stdout.print("{s}{s}{s} Examples{s}\n", .{ Symbols.check_mark, Colors.bright_blue, Colors.bold, Colors.reset });
    try stdout.print("{s}{s}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━{s}\n", .{ Colors.bright_black, Colors.dim, Colors.reset });
    try stdout.print("  {s}{s}locc{s}                    {s}{s}Count lines in current directory{s}\n", .{ Colors.bright_cyan, Colors.bold, Colors.reset, Colors.bright_black, Colors.dim, Colors.reset });
    try stdout.print("  {s}{s}locc /path/to/project{s}   {s}{s}Count lines in specific directory{s}\n", .{ Colors.bright_cyan, Colors.bold, Colors.reset, Colors.bright_black, Colors.dim, Colors.reset });
    try stdout.print("  {s}{s}locc --file-mode{s}        {s}{s}Show file counts instead of lines{s}\n", .{ Colors.bright_cyan, Colors.bold, Colors.reset, Colors.bright_black, Colors.dim, Colors.reset });

    try stdout.print("\n", .{});

    // Footer
    try stdout.print("{s}{s}More information: {s}{s}https://github.com/Jotrorox/locc{s}\n", .{ Colors.bright_black, Colors.dim, Colors.bright_blue, Colors.underline, Colors.reset });
    try stdout.print("\n", .{});
}

// Helper function to get color for different file types
fn getFileTypeColor(file_type: []const u8) []const u8 {
    // Convert to lowercase for comparison
    var lowercase_buf: [32]u8 = undefined;
    const lowercase = if (file_type.len < lowercase_buf.len) blk: {
        for (file_type, 0..) |c, i| {
            lowercase_buf[i] = std.ascii.toLower(c);
        }
        break :blk lowercase_buf[0..file_type.len];
    } else file_type;

    if (std.mem.eql(u8, lowercase, "zig")) return Colors.bright_yellow;
    if (std.mem.eql(u8, lowercase, "c") or std.mem.eql(u8, lowercase, "c++")) return Colors.blue;
    if (std.mem.eql(u8, lowercase, "rust")) return Colors.red;
    if (std.mem.eql(u8, lowercase, "go")) return Colors.cyan;
    if (std.mem.eql(u8, lowercase, "python")) return Colors.green;
    if (std.mem.eql(u8, lowercase, "javascript") or std.mem.eql(u8, lowercase, "typescript")) return Colors.yellow;
    if (std.mem.eql(u8, lowercase, "java")) return Colors.red;
    if (std.mem.eql(u8, lowercase, "markdown")) return Colors.bright_blue;
    if (std.mem.eql(u8, lowercase, "json") or std.mem.eql(u8, lowercase, "yaml")) return Colors.magenta;
    if (std.mem.eql(u8, lowercase, "html") or std.mem.eql(u8, lowercase, "css")) return Colors.bright_red;
    if (std.mem.eql(u8, lowercase, "shell") or std.mem.eql(u8, lowercase, "bash")) return Colors.bright_green;

    return Colors.bright_white; // Default color
}

// Helper function to format large numbers with commas
fn formatNumber(allocator: std.mem.Allocator, number: u32) ![]u8 {
    const num_str = try std.fmt.allocPrint(allocator, "{d}", .{number});
    defer allocator.free(num_str);

    if (num_str.len <= 3) {
        return try allocator.dupe(u8, num_str);
    }

    const comma_count = (num_str.len - 1) / 3;
    const result_len = num_str.len + comma_count;
    const result = try allocator.alloc(u8, result_len);

    var result_idx: usize = result_len;
    var num_idx: usize = num_str.len;
    var digit_count: u32 = 0;

    while (num_idx > 0) {
        num_idx -= 1;
        result_idx -= 1;
        result[result_idx] = num_str[num_idx];
        digit_count += 1;

        if (digit_count == 3 and num_idx > 0) {
            result_idx -= 1;
            result[result_idx] = ',';
            digit_count = 0;
        }
    }

    return result;
}
