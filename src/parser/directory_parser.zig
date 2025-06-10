const std = @import("std");
const StringArrayHashMap = std.StringArrayHashMap;
const Config = @import("../config/config.zig").Config;
const line_counter = @import("../utils/line_counter.zig");

pub const ParsedDirectory = struct {
    directory: std.fs.Dir,
    file_count: StringArrayHashMap(u32),
    line_count: StringArrayHashMap(u32), // New field for line counts
    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator, path: []const u8) !ParsedDirectory {
        const dir = try std.fs.cwd().openDir(path, .{ .iterate = true });
        return ParsedDirectory{
            .directory = dir,
            .file_count = StringArrayHashMap(u32).init(allocator),
            .line_count = StringArrayHashMap(u32).init(allocator),
            .allocator = allocator,
        };
    }

    pub fn initWithDir(allocator: std.mem.Allocator, dir: std.fs.Dir) ParsedDirectory {
        return ParsedDirectory{
            .directory = dir,
            .file_count = StringArrayHashMap(u32).init(allocator),
            .line_count = StringArrayHashMap(u32).init(allocator),
            .allocator = allocator,
        };
    }

    pub fn initWithCount(allocator: std.mem.Allocator, dir: std.fs.Dir, file_count: StringArrayHashMap(u32), line_count: StringArrayHashMap(u32)) ParsedDirectory {
        return ParsedDirectory{
            .directory = dir,
            .file_count = file_count,
            .line_count = line_count,
            .allocator = allocator,
        };
    }

    pub fn deinit(self: *ParsedDirectory) void {
        self.file_count.deinit();
        self.line_count.deinit();
        self.directory.close();
    }

    pub fn merge(self: *ParsedDirectory, other: ParsedDirectory) !void {
        for (other.file_count.keys()) |key| {
            const count = other.file_count.get(key) orelse @panic("Key not found");
            const existing_count = self.file_count.get(key) orelse 0;
            try self.file_count.put(key, existing_count + count);
        }

        for (other.line_count.keys()) |key| {
            const count = other.line_count.get(key) orelse @panic("Key not found");
            const existing_count = self.line_count.get(key) orelse 0;
            try self.line_count.put(key, existing_count + count);
        }
    }

    pub fn mergeHashMap(self: *ParsedDirectory, file_count_map: StringArrayHashMap(u32), line_count_map: StringArrayHashMap(u32)) !void {
        for (file_count_map.keys()) |key| {
            const count = file_count_map.get(key) orelse @panic("Key not found");
            const existing_count = self.file_count.get(key) orelse 0;
            try self.file_count.put(key, existing_count + count);
        }

        for (line_count_map.keys()) |key| {
            const count = line_count_map.get(key) orelse @panic("Key not found");
            const existing_count = self.line_count.get(key) orelse 0;
            try self.line_count.put(key, existing_count + count);
        }
    }

    pub fn getFileCount(self: *const ParsedDirectory, path: []const u8) u32 {
        return self.file_count.get(path) orelse 0;
    }

    pub fn getLineCount(self: *const ParsedDirectory, path: []const u8) u32 {
        return self.line_count.get(path) orelse 0;
    }
};

pub fn parseDirectory(allocator: std.mem.Allocator, path: []const u8, config: *const Config) !ParsedDirectory {
    var dir = try std.fs.cwd().openDir(path, .{ .iterate = true });

    var tmpFileMap = StringArrayHashMap(u32).init(allocator);
    var tmpLineMap = StringArrayHashMap(u32).init(allocator);

    if (config.shouldIgnore(path)) {
        std.debug.print("Ignoring directory: {s}\n", .{path});
        return ParsedDirectory.initWithDir(allocator, dir);
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
                            // Update file count
                            const file_count = tmpFileMap.get(ext) orelse 0;
                            try tmpFileMap.put(ext, file_count + 1);

                            // Count lines in the file
                            const full_path = try std.fmt.allocPrint(allocator, "{s}/{s}", .{ path, entry.name });
                            defer allocator.free(full_path);

                            const lines = line_counter.countLinesInFile(allocator, full_path) catch |err| blk: {
                                std.debug.print("Warning: Could not count lines in {s}: {}\n", .{ full_path, err });
                                break :blk 0;
                            };

                            const line_count = tmpLineMap.get(ext) orelse 0;
                            try tmpLineMap.put(ext, line_count + lines);
                            break;
                        }
                    }
                }
            },
            .directory => {
                if (config.shouldIgnore(entry.name)) continue;

                const new_path = try std.fmt.allocPrint(allocator, "{s}/{s}", .{ path, entry.name });
                defer allocator.free(new_path);
                var subDir = try parseDirectory(allocator, new_path, config);
                defer subDir.deinit();

                // Merge file counts
                for (subDir.file_count.keys()) |key| {
                    const count = subDir.file_count.get(key) orelse 0;
                    const existing_count = tmpFileMap.get(key) orelse 0;
                    try tmpFileMap.put(key, existing_count + count);
                }

                // Merge line counts
                for (subDir.line_count.keys()) |key| {
                    const count = subDir.line_count.get(key) orelse 0;
                    const existing_count = tmpLineMap.get(key) orelse 0;
                    try tmpLineMap.put(key, existing_count + count);
                }
            },
            else => continue,
        }
    }

    return ParsedDirectory.initWithCount(allocator, dir, tmpFileMap, tmpLineMap);
}
