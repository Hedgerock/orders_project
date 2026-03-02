# ADR-0005: Publishing events strategy

- Status: Accepted
- Date: 2026-02-24
- Owners: Backend Team

## Context
System must guarantee reliable delivery of domain events (e.g., OrderCreated, PaymentProcessed) to external consumers.
See [ADR-0002](../adr/0002-BOTEC-calculations.md) for load calculations, event volume expected to correlate with order creation (~ 400k/day)

## Decision Drivers
- Guarantee event delivery even under failures
- Simple implementation for small team
- Alignment with existing relational DB transactions
- Ability to monitor and retry failed deliveries

## Decision
Use Outbox pattern with background processor to publish events to message broker (e.g., Kafka)

## Alternatives Considered
- **Direct-publish**: simple but unreliable under failures
- **Transactional Outbox + CDC**: reliable but requires additional infrastructure
- **Event Sourcing**: powerful but complex for small team

## Consequences
### Pros
- Reliable delivery aligned with DB transactions
- Simple implementation compared to Event Sourcing
- Easy to monitor pending events

### Cons
- Requires Outbox table in DB
- Background processor adds operational overhead
- Possible delivery latency compared to direct publish

## Technical Impact
- Outbox table must be added to DB schema
- Background job/service required to poll and publish events
- Monitoring of pending events count and retry logic
- Latency impact: events delivered asynchronously, not inline with request
- Monitoring via Prometheus:
    - **Pending events count** (SLO: < 1000 events in queue)
    - **Average delivery latency** (SLO p95 < 5s from DB commit to broker publish)
    - **Retry attempts** (alert if retries > 3 for same event)
    - **Failed deliveries** (SLO: error rate < 0.1%)

## Related ADRs
- [ADR-0001: Non-functional requirements (SLO/SLI)](../adr/0001-non-functional-requirements.md) 
- [ADR-0002: BOTEC calculations](../adr/0002-BOTEC-calculations.md) 
- [ADR-0003: Project architecture](../adr/0003-project-architecture.md)
- [ADR-0004: Caching strategy](../adr/0004-caching-strategy.md)