# Configuration System

The `locc` (Lines of Code Counter) tool uses an embedded JSON configuration file to specify which directories and files should be ignored during code analysis.

## Configuration File

The configuration is stored in `src/config/config.json` and is embedded into the binary at compile time using Zig's `@embedFile` directive.

### Structure

```json
{
  "ignored_paths": [
    "directory_name",
    "file_name",
    "*.extension"
  ]
}
```

### Supported Patterns

1. **Exact Match**: Directory or file names that match exactly
   - Example: `.git`, `node_modules`, `target`

2. **Wildcard Patterns**: Simple glob patterns using `*`
   - Example: `*.log` matches all files ending with `.log`
   - Example: `temp*` matches all files/directories starting with `temp`

### Default Ignored Paths

The default configuration includes commonly ignored directories and files:

#### Version Control
- `.git`, `.svn`, `.hg`, `.bzr`

#### Package Managers
- `node_modules`, `vendor`, `bower_components`

#### Build Outputs
- `.zig-cache`, `zig-out`, `target`, `build`, `dist`, `out`, `bin`, `obj`

#### IDEs and Editors
- `.vscode`, `.idea`, `.vs`, `.vscode-test`

#### Python Cache
- `__pycache__`, `.pytest_cache`, `.mypy_cache`, `.coverage`, `.tox`, `.nox`

#### System Files
- `.DS_Store`, `Thumbs.db`, `desktop.ini`

#### Temporary Files
- `tmp`, `temp`, `.tmp`, `.temp`, `logs`

#### Log Files
- `*.log`

#### Web Development
- `.sass-cache`, `.parcel-cache`, `.next`, `.nuxt`, `.cache`, `coverage`

#### Environment Files
- `.env`, `.env.local`, `.env.development.local`, `.env.test.local`, `.env.production.local`

## Customizing Configuration

To modify which paths are ignored:

1. Edit `src/config/config.json`
2. Add or remove entries from the `ignored_paths` array
3. Rebuild the application with `zig build`

The configuration is embedded at compile time, so changes require a rebuild.

## Implementation Details

- Configuration is loaded using Zig's JSON parser
- Memory management is handled automatically with proper cleanup
- Error handling provides specific messages for common configuration issues
- Pattern matching supports simple wildcards with `*`

## Error Handling

The config system provides specific error messages for:
- Missing `ignored_paths` field
- Invalid JSON syntax
- Memory allocation failures

All errors are reported clearly to help with debugging configuration issues.