# Clean Architecture Rules

## Layer Definitions & Dependency Direction

```
Domain (entities, value objects) → Use-Cases (business logic) → Adapters/Repositories (implementations) → Handlers/Controllers (infrastructure)
```

**Inner layers NEVER import from outer layers.** Dependencies always point inward.

## Layer Responsibilities

### Handlers/Controllers (outermost layer)

- HTTP/event concerns ONLY — parse request, validate input shape, call use-case, format response
- **NO business logic** — no conditionals beyond input validation/routing
- **NO direct database or SDK calls** — never import database clients directly
- **NO direct repository calls** — always go through a use-case

### Use-Cases (business logic layer)

- Single responsibility — one class/function per business operation
- Constructor-injected dependencies via interfaces (ports)
- Maximum ~100 lines per use-case — if larger, split into orchestrator + focused use-cases
- Maximum 5 constructor dependencies — more suggests too many responsibilities
- **NO infrastructure imports** — no database clients, no HTTP framework, no SDK
- **NO direct environment variable access** — receive config through constructor injection

### Repositories (data access layer)

- `interfaces/` — port definitions that use-cases depend on
- `impl/` — database implementations of those interfaces
- All database code lives here — never in use-cases or handlers
- Must use parameterized queries — never string interpolation

### Adapters (external services layer)

- `interfaces/` — port definitions for external services
- `impl/` — SDK/API implementations
- Always behind interfaces — use-cases never import implementations directly

### Domain (innermost layer)

- Pure types, entities, value objects
- **NO infrastructure imports** — no database, no framework dependencies

## Folder Structure Per Service/Module

```
src/
├── handlers/          # Entry points (thin)
├── use-cases/         # Business logic (one class per operation)
├── repositories/
│   ├── interfaces/    # Port definitions
│   └── impl/          # Database implementations
├── adapters/
│   ├── interfaces/    # Port definitions for external services
│   └── impl/          # SDK implementations
├── domain/            # Types, entities, value objects
└── types/             # DTOs, input/output types
```

## Anti-Patterns to Flag

- Database client instantiation outside `repositories/impl/`
- Imports from another module's internal `src/` directory
- Use-case with >5 constructor dependencies
- Handler/controller calling repository directly (skipping use-case)
- Business logic in handler (conditionals beyond input validation)
- Use-case >100 lines (needs splitting)
- Missing `interfaces/` directory alongside `impl/`
- Direct environment variable access in use-cases or domain
