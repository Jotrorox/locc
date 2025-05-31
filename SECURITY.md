# Security Policy

## Supported Versions

We take security seriously and will provide security updates for the following versions:

| Version | Supported          |
| ------- | ------------------ |
| 0.1.x   | :white_check_mark: |

## Reporting a Vulnerability

If you discover a security vulnerability in LOCC, please report it responsibly:

### How to Report

1. **Do not** create a public GitHub issue for security vulnerabilities
2. **Email** us directly at: [mail@jotrorox.com](mailto:mail@jotrorox.com)
3. **Include** as much detail as possible:
   - Description of the vulnerability
   - Steps to reproduce the issue
   - Potential impact
   - Any suggested fixes (if you have them)

### What to Expect

- **Acknowledgment**: We will acknowledge receipt of your report within 48 hours
- **Investigation**: We will investigate and validate the vulnerability
- **Timeline**: We aim to provide an initial response within 2 business days
- **Updates**: We will keep you informed of our progress
- **Credit**: With your permission, we will credit you in the security advisory

### Security Considerations for LOCC

While LOCC is a file scanning tool, potential security concerns might include:

- **Path traversal**: Malicious file paths that could access unintended files
- **Resource exhaustion**: Very large files or deeply nested directories
- **File access**: Reading files outside intended directories
- **Memory usage**: Excessive memory consumption with malformed files

### Best Practices for Users

When using LOCC:

1. **Run with appropriate permissions**: Don't run as root unless necessary
2. **Scan trusted directories**: Be cautious when scanning untrusted code repositories
3. **Monitor resource usage**: Be aware when scanning very large codebases
4. **Keep updated**: Use the latest version to benefit from security fixes

### Scope

This security policy applies to:

- The main LOCC binary and source code
- Official releases and distribution methods
- Security issues that could affect users' systems or data

### Out of Scope

The following are generally considered out of scope:

- Issues in third-party dependencies (please report to respective maintainers)
- Performance issues that don't pose security risks
- Issues requiring physical access to the user's machine
- Social engineering attacks

## Security Updates

Security updates will be released as patch versions and announced through:

- GitHub Security Advisories
- Release notes
- README updates

## Questions?

If you have questions about this security policy or need clarification on whether an issue should be reported as a security vulnerability, please contact us at [mail@jotrorox.com](mailto:mail@jotrorox.com) or over on [discord](https://discord.gg/RVr4cceFUt) (@jotrorox).

Thank you for helping keep LOCC and its users safe!
