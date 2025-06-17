pub const CliConfig = struct {
    program_name: []const u8,
    help: bool,
    file_mode: bool, // true = show file counts, false = show line counts (default)
    args: []const []const u8,
    regex: ?[]const u8,

    pub fn init(program_name: []const u8, help: bool, file_mode: bool, args: []const []const u8) CliConfig {
        return CliConfig{
            .program_name = program_name,
            .help = help,
            .file_mode = file_mode,
            .args = args,
            .regex = null,
        };
    }

    pub fn initDefault(program_name: []const u8) CliConfig {
        return CliConfig{
            .program_name = program_name,
            .help = false,
            .file_mode = false, // Default to line counting mode
            .args = &[_][]const u8{},
            .regex = null,
        };
    }
};
