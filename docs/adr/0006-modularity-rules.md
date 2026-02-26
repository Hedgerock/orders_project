# ADR-0006: Modularity rules

- Status: Accepted
- Date: 2026-02-25
- Owners: Backend Team

## Rules

1. **Cross-module calls only via public facades**:
   - All interactions between modules must go through `..public..` or `..api..` packages
   - Direct calls to internal classes (`..infra..`, `..domain`) of another module are forbidden

2. **No imports of another module's** `..infra`:
    - Each module's infrastructure layer is isolated
    - Only the owning module may use its `infra`. Shared infrastructure requires a dedicated module and an ADR

3. **No cyclic dependencies**:
    - Module dependencies must form an acyclic graph
    - Any attempt to introduce cycles will be blocked by ArchUnit/linter checks

4. **No "shared domain" without ADR**:
    - Domain entities (e.g., `User`, `Order`) belong to a specific module
    - Moving them into a shared module is allowed only after an ADR with clear justification

5. **New dependencies require explanation**
    - Every new cross-module dependency must be explained in the PR description
    - Controversial cases must be backed by an ADR
    
## Consequences

- Positive: Keeps the monolith modular and maintainable
- Negative: Slight overhead in PR reviews and ADR writing
- Trigger: If rules are repeatedly violated, consider splitting into microservices