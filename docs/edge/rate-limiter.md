# Rate Limiting algorithm selection

## Token Bucket:
- **Pros**:
  - Tolerates short traffic spikes
  - Flexible configuration
  - Simple implementation
- **Cons**:
  - Less strict traffic uniformity control

## Sliding Window Counter:
- **Pros**:
    - Strict and predictable rate control
- **Cons**:
    - More computationally expensive
    - Less flexible in handling bursts

## Decision
Considering the system peak load of 18.5 RPS ([ADR-0002](../adr/0002-BOTEC-calculations.md)) and the monolithic architecture ([ADR-0003](../adr/0003-project-architecture.md)), the Token Bucket
algorithm is selected

### Rationale:
- Simple implementation in Redis
- Handles short traffic spikes well (e.g., marketing campaigns)
- Easy to explain and support by the team without complex DevOps setup

## Failure Mode Strategy
Redis is a critical component ([ADR-0002 (BOTEC)](../adr/0002-BOTEC-calculations.md): 90% cache hit rate), therefore failure handling must be explicit

## Route Classification

### Critical routes (e.g., `/orders`) -> fail-close:
- Prefer rejecting requests over risking financial loss or SLA violations

### Non-critical (e.g., `/status`, `/health`) -> fail-open
- Better UX
- Load impact is acceptable

## Conclusions:
- Algorithm: Token Bucket (simplicity + flexibility)
- Policies: Global, per-user/API key and per route limits
- Failure strategy:
  - Fail-close for critical routes
  - Fail-open for non-critical routes
- Documentation: Create a new ADR (e.g., ADR-#### Rate Limiting Design) and link it with:
  - [ADR-0001 (SLO/SLI)](../adr/0001-non-functional-requirements.md)
  - [ADR-0002 (BOTEC)](../adr/0002-BOTEC-calculations.md)
  - [ADR-003 (architecture)](../adr/0003-project-architecture.md)