# Security

Claudin takes a defense-in-depth approach to security with multiple layers of protection.

## Security Layers

```mermaid
graph TB
    A[Permissions] -->|First line| B[Deny Rules]
    B -->|Second line| C[PreToolUse Hooks]
    C -->|Third line| D[File Protection Hook]
    D -->|Fourth line| E[Audit Logging Hook]

    style A fill:#e74c3c,color:#fff
    style B fill:#e67e22,color:#fff
    style C fill:#f39c12,color:#fff
    style D fill:#27ae60,color:#fff
    style E fill:#3498db,color:#fff
```

1. **[Permissions](../features/permissions.md)** — deny dangerous commands outright
2. **[Hooks](hook-patterns.md)** — block sensitive file access, audit changes
3. **[.claudeignore](../features/claudeignore.md)** — prevent reading sensitive files
4. **[Rules](../features/rules.md)** — enforce security coding standards

## Quick Checklist

- [ ] `.env`, `.pem`, `.key` files are protected by hooks
- [ ] `git push --force` is denied in permissions
- [ ] `rm -rf /` is denied in permissions
- [ ] Audit logging is enabled for file edits
- [ ] CLAUDE.md has security rules section
- [ ] No credentials in version control
