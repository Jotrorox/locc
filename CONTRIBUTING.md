# Contributing to LOCC

Thank you for your interest in contributing to LOCC! We welcome contributions from the community and are pleased to have them.

## How to Contribute

### Reporting Issues

Before creating an issue, please:

1. **Search existing issues** to avoid duplicates
2. **Use the latest version** to ensure the issue hasn't been fixed
3. **Provide clear reproduction steps** and expected vs. actual behavior
4. **Include relevant details** like OS, Go version, and file types being scanned

### Suggesting Features

We'd love to hear your ideas! When suggesting features:

1. **Check existing issues** for similar requests
2. **Explain the use case** and why it would be valuable
3. **Consider the scope** - keep it focused and achievable
4. **Discuss implementation** if you have ideas

### Code Contributions

#### Getting Started

1. **Fork the repository** on GitHub
2. **Clone your fork** locally:
   ```bash
   git clone https://github.com/YOUR_USERNAME/locc.git
   cd locc
   ```
3. **Create a branch** for your changes:
   ```bash
   git checkout -b feature/your-feature-name
   ```

#### Development Setup

1. **Install Go 1.24+** (check with `go version`)
2. **Install dependencies**:
   ```bash
   go mod download
   ```
3. **Build and test**:
   ```bash
   go build -o locc main.go
   ./locc .
   ```

#### Making Changes

1. **Follow Go conventions**:
   - Use `gofmt` to format your code
   - Run `go vet` to check for issues
   - Write clear, descriptive variable and function names
   - Add comments for exported functions and complex logic

2. **Test your changes**:
   - Test with various file types and directory structures
   - Ensure both file mode (`-f`) and type mode work correctly
   - Test error handling with invalid paths or permissions

3. **Keep commits focused**:
   - One logical change per commit
   - Write clear commit messages
   - Use present tense ("Add feature" not "Added feature")

#### Code Style

- Follow standard Go formatting (`gofmt`)
- Use meaningful variable names
- Keep functions focused and reasonably sized
- Add comments for exported functions
- Handle errors appropriately
- Maintain consistent styling with existing code

#### Performance Considerations

LOCC prioritizes performance. When contributing:

- **Profile your changes** if they affect core scanning logic
- **Use efficient algorithms** for file processing
- **Minimize memory allocations** in hot paths
- **Consider large repositories** when testing

### Pull Request Process

1. **Update documentation** if needed (README, comments)
2. **Test thoroughly** on different platforms if possible
3. **Write a clear PR description**:
   - What changes were made and why
   - Any breaking changes
   - How to test the changes
4. **Be responsive** to feedback and requests for changes

### Adding New Language Support

To add support for a new programming language:

1. **Add the file extension** to `fileTypeMap` in `main.go`
2. **Use a descriptive language name** (e.g., "TypeScript" not "TS")
3. **Test with real files** of that language type
4. **Update the README** to include the new language in the supported list

Example:
```go
".zig": "Zig",
".nim": "Nim",
```

### Development Guidelines

#### Performance
- Maintain or improve scanning speed
- Profile changes that affect the core scanning loop
- Use efficient data structures and algorithms

#### Compatibility
- Ensure changes work on Linux, macOS, and Windows
- Support Go 1.24+
- Maintain backward compatibility for command-line flags

#### Testing
- Test with various project structures
- Include edge cases (empty files, binary files, deep directories)
- Verify output formatting and colors

### Community

- **Be respectful** and constructive in all interactions
- **Help others** when you can
- **Follow the Code of Conduct**

### Questions?

If you have questions about contributing:

1. Check existing issues and discussions
2. Create a new issue with the "question" label
3. Be specific about what you're trying to achieve

Thank you for helping make LOCC better! 🚀
