pub const CliConfig = struct {
    program_name: []const u8,
    help: bool,
    file_mode: bool, // true = show line counts, false = show file counts (default)
    args: []const []const u8,

    pub fn init(program_name: []const u8, help: bool, file_mode: bool, args: []const []const u8) CliConfig {
        return CliConfig{
            .program_name = program_name,
            .help = help,
            .file_mode = file_mode,
            .args = args,
        };
    }

    pub fn initDefault(program_name: []const u8) CliConfig {
        return CliConfig{
            .program_name = program_name,
            .help = false,
            .file_mode = false, // Default to file counting mode
            .args = &[_][]const u8{},
        };
    }
};
