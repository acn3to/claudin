# CLAUDE.md Writing Guide

## The Golden Rule

**Include what Claude can't infer from code.** If Claude would figure it out by reading your source files, don't put it in CLAUDE.md.

## Good vs Bad Examples

### Project Description

=== "Good"
    ```markdown
    ## What This Is
    REST API for managing gym memberships. Serves mobile app and admin dashboard.
    Multi-tenant: each gym is a separate tenant with isolated data.
    ```

=== "Bad"
    ```markdown
    ## What This Is
    This is a Node.js application built with Express.js that uses MongoDB
    as its primary database. It follows the MVC pattern and uses JWT for
    authentication. The code is written in TypeScript and uses Jest for testing.
    ```
    Claude can see all of this from `package.json` and the code.

### Conventions

=== "Good"
    ```markdown
    ## Conventions
    - API responses always: `{ success: boolean, data?: T, error?: string }`
    - Database migrations run before deployment: `npm run migrate`
    - Feature branches: `feat/TICKET-123-short-description`
    ```

=== "Bad"
    ```markdown
    ## Conventions
    - Use async/await instead of callbacks
    - Use const instead of let when possible
    - Use arrow functions for callbacks
    ```
    Claude already knows standard JavaScript best practices.

### Commands

=== "Good"
    ```markdown
    ## Commands
    npm run dev              # Starts with hot reload + mock auth
    npm run test:integration # Requires Docker running
    npm run seed:dev         # Loads test data (resets DB!)
    ```

=== "Bad"
    ```markdown
    ## Commands
    npm install              # Install dependencies
    npm start                # Start the server
    npm test                 # Run tests
    ```
    These are obvious from `package.json`.

## Template

See `template/CLAUDE.md` for a ready-to-use template with the right sections.

## Size Guidelines

| Lines | Rating | Action |
|-------|--------|--------|
| < 50 | Lean | Could add more conventions |
| 50-150 | Ideal | Good balance |
| 150-200 | Acceptable | Consider moving details to skills |
| 200+ | Too long | Split into CLAUDE.md + skills/rules |
