---
name: refactor-to-clean-arch
description: Analyzes a service or module for clean architecture violations and proposes a refactoring plan. Shows before/after structure, affected files, and step-by-step instructions.
allowed_tools:
  - Read
  - Glob
  - Grep
  - Bash
user_invocable: true
argument_hint: "<module-name>"
---

# Refactor to Clean Architecture

Analyze the specified module and produce a detailed refactoring plan to align it with clean architecture principles.

## Input

The user provides a module or service name. Locate the module's source code directory.

## Analysis Steps

### 1. Map Current Architecture

- Glob all source files in the module
- Read each file and classify by layer:
  - `handlers/` or `controllers/` — Entry points
  - `use-cases/` — Business logic
  - `repositories/` — Data access
  - `adapters/` — External service wrappers
  - `services/` — Legacy service layer (may need conversion)
  - `domain/` — Entities and value objects
  - `types/` — DTOs and interfaces
- Note any files that don't fit the expected structure

### 2. Identify Violations

Check against `.claude/rules/clean-architecture.md`:

- **Missing use-case layer** — business logic in handlers
- **Fat use-cases** — >100 lines doing multiple things
- **Missing interfaces** — implementations without port definitions
- **Direct SDK/DB usage in handlers** — infrastructure imports in handler files
- **Cross-layer imports** — inner layers importing from outer layers
- **Missing adapter abstraction** — external services called directly without interface

### 3. Propose Refactoring Plan

For each violation, propose specific extractions:

- What code to extract from the current location
- Where to create the new file
- What interface to define
- What dependencies to inject
- What tests need updating

### 4. Show Before/After

Display the directory structure comparison:

```
BEFORE:                      AFTER:
src/                         src/
├── handlers/                ├── handlers/
│   └── item.handler.ts      │   └── item.handler.ts (thinned)
├── repositories/            ├── use-cases/
│   └── item.repository.ts   │   ├── create-item.use-case.ts
└── types/                   │   └── get-item.use-case.ts
                             ├── repositories/
                             │   ├── interfaces/
                             │   │   └── item.repository.interface.ts
                             │   └── impl/
                             │       └── item.repository.ts
                             ├── domain/
                             │   └── item.entity.ts
                             └── types/
```

### 5. List Affected Files

Table of every file that would be created, modified, or moved:

```
| Action   | File                                      | Description                |
|----------|-------------------------------------------|----------------------------|
| CREATE   | use-cases/create-item.use-case.ts         | Extracted from handler     |
| CREATE   | repositories/interfaces/item.repo.ts      | Port definition            |
| MODIFY   | handlers/item.handler.ts                  | Remove business logic      |
| MOVE     | repositories/item.repository.ts           | → repositories/impl/       |
```

## Output Format

```
## Refactoring Plan: <module-name>

### Current State
- Architecture score: X/10
- <summary of current structure>

### Violations Found
1. <violation with file:line reference>
2. ...

### Proposed Changes

#### Change 1: <description>
- **Extract from:** <source-file>:<lines>
- **Create:** <new-file>
- **Interface:** <interface-file>
- **Rationale:** <why this improves the architecture>

### Before/After Structure
<directory tree comparison>

### Affected Files
<table of actions>

### Migration Steps (in order)
1. <step with specific instructions>
2. ...

### Risk Assessment
- Breaking changes: <yes/no, details>
- Test updates needed: <list>
- Import path changes: <list>
```

## Rules

- This skill produces a PLAN only — it does NOT execute changes
- Always read actual code before proposing changes — never guess
- Reference specific line numbers and code snippets
- Consider test files that need updating
- Propose changes in dependency order (interfaces first, then implementations)
