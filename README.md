# LOCC - Lines of Code Counter

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Go Version](https://img.shields.io/badge/Go-1.24+-blue.svg)](https://golang.org/)

A fast and beautiful command-line tool for counting lines of code across multiple programming languages with colorful terminal output.

## Features

- 🚀 **Fast**: Optimized scanning with efficient file processing
- 🎨 **Beautiful**: Colorful terminal output powered by [Charm's Lipgloss](https://github.com/charmbracelet/lipgloss)
- 📊 **Two modes**: File-by-file view or grouped by language type
- 🔧 **Multiple languages**: Supports 30+ programming languages
- 📈 **Smart counting**: Excludes empty lines and whitespace-only lines
- 💻 **Cross-platform**: Works on Linux, macOS, and Windows

## Installation

### From Source

```bash
git clone https://github.com/jotrorox/locc.git
cd locc
go build -o locc main.go
```

### Using Go Install

```bash
go install github.com/jotrorox/locc@latest
```

## Usage

### Basic Usage

Count lines of code in a directory, grouped by file type:

```bash
locc /path/to/your/project
```

### File Mode

Show individual files instead of grouping by type:

```bash
locc --file-mode /path/to/your/project
# or
locc -f /path/to/your/project
```

### Examples

**Type mode (default):**
```
Scanning: /home/user/my-project
──────────────────────────────────────
Go                             5 files    234 lines
JavaScript                     3 files    156 lines
TypeScript                     2 files     89 lines
JSON                           1 files     12 lines
──────────────────────────────────────
Total                         11 files    491 lines
```

**File mode:**
```
Scanning: /home/user/my-project
──────────────────────────────────────
src/main.go                              234
src/utils.js                             89
src/types.ts                             67
config.json                              12
──────────────────────────────────────
Total                                   402
Files: 4
```

## Supported Languages

LOCC supports 30+ programming languages including:

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

- **Large buffer sizes** for efficient file reading
- **Byte-level processing** for line counting
- **Pre-allocated slices** to reduce memory allocations
- **Smart path handling** without unnecessary string operations

## Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for details on how to contribute to this project.

## Code of Conduct

This project adheres to a [Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code.

## Security

If you discover a security vulnerability, please see our [Security Policy](SECURITY.md) for information on how to report it responsibly.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

Created by Johannes (Jotrorox) Müller

---

⭐ If you find this tool useful, please consider giving it a star on GitHub!
