# Project Name

## What This Project Is

<!-- Brief description: what does this project do, who uses it, and why does it exist? -->
<!-- Example: "REST API for managing user subscriptions, serving our mobile app and admin dashboard." -->

## Tech Stack

<!-- List your stack so Claude knows what tools, frameworks, and patterns to expect. -->
<!-- Example:
- **Runtime**: Node.js 20 + TypeScript 5
- **Framework**: Express.js
- **Database**: MongoDB (Mongoose ODM)
- **Testing**: Jest + Supertest
- **CI/CD**: GitHub Actions
- **Infra**: Docker, AWS ECS
-->

## Project Structure

<!-- Show the directory layout so Claude can navigate efficiently. -->
<!-- Example:
```
├── src/
│   ├── controllers/    # Request handlers
│   ├── services/       # Business logic
│   ├── models/         # Database schemas
│   ├── middlewares/     # Auth, validation, error handling
│   └── utils/          # Helpers
├── tests/              # Jest test files
├── config/             # Environment-specific configs
└── scripts/            # Build and deploy scripts
```
-->

## Key Conventions

<!-- Rules that Claude can't infer from code alone. Only include non-obvious things. -->
<!-- Example:
- All API responses follow `{ success: boolean, data?: T, error?: string }`
- Environment variables are accessed through `src/config/env.ts`, never directly
- Database migrations run before deployment via `npm run migrate`
- Feature branches follow `feat/TICKET-123-short-description` naming
-->

## Common Commands

<!-- Commands Claude will need to run. Only include non-obvious ones. -->
```bash
# Development
# npm run dev

# Testing
# npm test
# npm run test:watch

# Build
# npm run build

# Lint
# npm run lint
# npm run lint:fix
```

## Security Rules

<!-- Non-negotiable security constraints for this project. -->
- NEVER read, edit, or commit `.env` files, `.pem` keys, or credential files
- NEVER hardcode API keys, tokens, passwords, or connection strings
- All credentials in documentation must be placeholders: `<YOUR_API_KEY>`
- NEVER `git push --force` to main/master
