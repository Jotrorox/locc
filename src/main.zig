const std = @import("std");

pub fn main() !void {
    var argIter = std.process.ArgIterator.init();
    defer argIter.deinit();
    const current_dir = std.fs.cwd();

    const program_name = argIter.next() orelse @panic("The program doesn't have a program name?");
    const path = argIter.next() orelse ".";
    std.debug.print("Heyy: {s}\n", .{program_name});
    std.debug.print("Path: {s}\n", .{path});

    var dir = try current_dir.openDir(path, .{.iterate = true});
    defer dir.close();

    var iterator = dir.iterate();
    while (try iterator.next()) |entry| {
        std.debug.print("Name: {s}\n", .{entry.name});
    }
}
