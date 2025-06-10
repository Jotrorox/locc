const std = @import("std");

pub const LineCountError = error{
    FileNotFound,
    AccessDenied,
    OutOfMemory,
    UnexpectedError,
};

/// Count non-empty lines in a file, excluding whitespace-only lines
pub fn countLinesInFile(allocator: std.mem.Allocator, file_path: []const u8) LineCountError!u32 {
    const file = std.fs.cwd().openFile(file_path, .{}) catch |err| switch (err) {
        error.FileNotFound => return LineCountError.FileNotFound,
        error.AccessDenied => return LineCountError.AccessDenied,
        else => return LineCountError.UnexpectedError,
    };
    defer file.close();

    // Create a buffered reader for better performance
    var buf_reader = std.io.bufferedReader(file.reader());
    var reader = buf_reader.reader();

    var line_count: u32 = 0;
    var line_buffer = std.ArrayList(u8).init(allocator);
    defer line_buffer.deinit();

    while (true) {
        line_buffer.clearRetainingCapacity();
        reader.readUntilDelimiterArrayList(&line_buffer, '\n', std.math.maxInt(usize)) catch |err| switch (err) {
            error.EndOfStream => break,
            error.OutOfMemory => return LineCountError.OutOfMemory,
            else => return LineCountError.UnexpectedError,
        };

        // Check if line has non-whitespace content
        var has_content = false;
        for (line_buffer.items) |byte| {
            if (byte != ' ' and byte != '\t' and byte != '\r') {
                has_content = true;
                break;
            }
        }

        if (has_content) {
            line_count += 1;
        }
    }

    return line_count;
}
