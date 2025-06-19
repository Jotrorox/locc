# LOCC - Lines of Code Counter

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge&logoColo=white)](https://opensource.org/licenses/MIT)
[![Zig](https://img.shields.io/badge/Zig-%23F7A41D.svg?style=for-the-badge&logo=zig&logoColor=white)](https://ziglang.org)

A fast and beautiful command-line tool for counting lines of code across multiple programming languages with colorful terminal output.

## Features

- :zap: **Fast**: Optimized for speed, written in Zig
- :art: **Beautiful Output**: Colorful and easy-to-read terminal output
- :file_folder: **Multi-language Support**: Counts lines for a wide range of programming languages
- :bar_chart: **File Mode**: Show file counts grouped by type
- :mag: **Pattern Filtering**: Filter files using wildcards (* and ?) for precise control
- :gear: **Configurable**: Easily ignore directories and files with a JSON configuration file

## Installation

### Download Pre-built Binaries

todo with the next minor release

### From Source

```bash
git clone https://github.com/jotrorox/locc.git
cd locc
zig build --release=small
```

## Usage

### Basic Usage

Count lines of code in a directory, grouped by file type:

```bash
# To run in the current folder
locc
# To run in a specific folder
locc /path/to/your/project
```

### File Mode

Show the file count, grouped by file type:

```bash
locc --file-mode /path/to/your/project
# or
locc -f /path/to/your/project
```

### Pattern Filtering

Filter files and directories using patterns with wildcards:

```bash
# Count only Zig files
locc -r "*.zig" /path/to/project

# Count only markdown files in file mode
locc -f -r "*.md" /path/to/project

# Count files with specific naming patterns
locc -r "test*.py" ./python-project
locc -r "*component*" ./react-app

# Use single character wildcard
locc -r "build.zi?" ./zig-project
```

### Pattern Syntax

The `-r`/`--regex` option supports simple wildcard patterns:
- `*` matches any sequence of characters (including none)
- `?` matches any single character
- Literal characters match exactly

Examples:
- `*.js` - matches all JavaScript files (main.js, app.js, etc.)
- `test*.py` - matches Python files starting with "test" (test_main.py, test_utils.py)
- `*component*.vue` - matches Vue files with "component" in the name
- `build.zi?` - matches files like build.zig, build.zip, etc.
- `*.{js,ts}` - Note: this requires shell expansion, use separate commands for multiple extensions

## Supported Languages

LOCC a heck ton of programming languages including but not limited to:

- **Systems**: C, C++, Rust, Go
- **Web**: JavaScript, TypeScript, HTML, CSS, SCSS
- **Backend**: Python, Java, C#, PHP, Ruby
- **Mobile**: Swift, Kotlin, Dart, Objective-C
- **Scripting**: Shell, Bash, PowerShell, Lua, Perl
- **Data**: JSON, YAML, TOML, SQL, XML
- **Functional**: Scala, R
- **Frameworks**: Vue, JSX, TSX

## Performance

LOCC is optimized for speed:

- :zap: Written in Zig for high performance
- :rocket: Fast parsing and counting algorithms
- :bar_chart: Efficient memory usage
- :tada: Handles large repositories with ease

## Releases

... will have to be setup first with the next minor release 

## Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for details on how to contribute to this project.

## Code of Conduct

This project adheres to a [Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code.

## Security

If you discover a security vulnerability, please see our [Security Policy](SECURITY.md) for information on how to report it responsibly.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

**Johannes (Jotrorox) Müller**
- GitHub: [@jotrorox](https://github.com/jotrorox)
- Email: [mail@jotrorox.com](mailto:mail@jotrorox.com)

---

⭐ If you find this tool useful, please consider giving it a star on GitHub!
