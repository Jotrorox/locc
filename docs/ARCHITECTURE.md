# Project Structure

The LOCC project has been restructured for better maintainability and modularity. Here's an overview of the current structure:

```
src/
├── main.zig                          # Entry point - minimal, just initializes and runs the app
├── core/
│   └── application.zig               # Main application logic and initialization
├── parser/
│   └── directory_parser.zig          # Directory traversal and file counting logic
├── display/
│   └── output.zig                    # Output formatting and display logic
├── cli/
│   ├── cli.zig                       # CLI parsing coordinator
│   ├── config.zig                    # CLI configuration structures
│   ├── parser.zig                    # Command-line argument parser
│   ├── command.zig                   # Command interface
│   └── commands/
│       └── help.zig                  # Help command implementation
└── config/
    ├── config.zig                    # Configuration loading and management
    └── config.json                   # Default configuration file
```

## Module Responsibilities

### `main.zig`
- Entry point of the application
- Sets up memory allocation
- Initializes and runs the Application
- Minimal error handling

### `core/application.zig`
- Central application coordinator
- Manages application lifecycle
- Coordinates between CLI, config, parser, and display modules
- Handles main application flow

### `parser/directory_parser.zig`
- `ParsedDirectory` struct for holding parsing results
- Directory traversal logic
- File counting and categorization
- Recursive directory parsing

### `display/output.zig`
- Result formatting and display
- Help message display
- Output utilities

### `cli/` module
- **`cli.zig`**: Main CLI coordinator
- **`config.zig`**: CLI configuration structures
- **`parser.zig`**: Argument parsing logic
- **`command.zig`**: Command interface definition
- **`commands/help.zig`**: Help command implementation

### `config/` module
- **`config.zig`**: Configuration loading and management
- **`config.json`**: Default configuration with file types and ignored paths

## Benefits of This Structure

1. **Separation of Concerns**: Each module has a clear, single responsibility
2. **Maintainability**: Code is organized logically and easy to find
3. **Testability**: Individual modules can be tested in isolation
4. **Extensibility**: New features can be added without touching core logic
5. **Reusability**: Modules can be reused across different parts of the application

## Building and Running

```bash
# Build the project
zig build

# Run with zig build
zig build run

# Run the compiled binary directly
./zig-out/bin/locc

# Show help
zig build run -- --help
# or
./zig-out/bin/locc --help
```

## Adding New Features

To add new functionality:

1. **New Commands**: Add to `src/cli/commands/` and register in `application.zig`
2. **New Parsers**: Extend or create new parsers in `src/parser/`
3. **New Output Formats**: Add to `src/display/output.zig`
4. **Configuration Changes**: Update `src/config/config.json` and related parsing logic
