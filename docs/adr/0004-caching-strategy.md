# ADR-0004: Caching strategy

- Status: Accepted
- Date: 2026-02-24
- Owners: Backend Team

## Context
Orders are frequently read through the API. Database load is high during peak hours (~18.5 RPS, see [ADR-0002](../adr/0002-BOTEC-calculations.md))
**Goal**: Accelerate API response times by reducing database queries

## Decision Drivers
- High read frequency on orders
- Need to reduce database load
- Simple implementation for small team
- Ability to monitor cache efficiency

## Decision
Use Cache-Aside pattern with Redis

## Alternatives Considered
- **Read-Through**: automatic population of cache by library
- **Write-Through**: synchronous writes to cache and DB
- **Write-Behind**: delayed writes to DB

## Consequences
### Pros
 - Simple implementation
 - Flexible control over cache population
 - Reduces DB load

### Cons
- Cache misses possible
- Additional logic in application code
- Risk of stale data if not properly invalidated

## Technical Impact
- Redis required as external service
- Monitoring of hit/miss ratio and latency via Prometheus
- CI/CD must include Redis setup and health checks
- Monitoring via Prometheus:
  - **Cache hit ratio** (target > 0.9)
  - **Eviction count** (unexpected growth may indicate memory pressure)
  - **Latency** (p95 < 5ms for get/set operations)
  - **Memory usage** (track against allocated limits)
  - **Connection errors / timeouts** (target > 0.9)

## Related ADRs
- [ADR-0001: Non-functional requirements (SLO/SLI)](../adr/0001-non-functional-requirements.md)
- [ADR-0002: BOTEC calculations](../adr/0002-BOTEC-calculations.md)