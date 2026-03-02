## Code Standards

### General
- Write clear, self-documenting code — prefer descriptive names over comments
- Keep functions focused — one function, one responsibility
- Handle errors explicitly — never swallow exceptions silently
- Validate input at system boundaries (API endpoints, user input, external data)

### Security
- Never hardcode secrets, API keys, tokens, or passwords
- Access credentials through environment variables or secret managers
- Sanitize user input before use in queries, HTML, or shell commands
- Log errors without exposing stack traces or sensitive data to end users

### Git
- Write descriptive commit messages explaining WHY, not WHAT
- Never force push to main/master
- Keep commits focused — one logical change per commit
