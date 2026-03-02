# ADR-0003: Project architecture

- Status: Accepted
- Date: 2026-02-24
- Owners: Backend Team

## Context
Startup, team 6-8 developers, limited budget.
Need an architecture, which can deliver new features quickly, minimized costs on infrastructure
and DevOps, and also to make onboarding process for new teammates easy as possible

## Decision Drivers
- Simple support and development
- Minimal costs on infrastructure
- Limited experience of the team in DevOps and microservices architecture
- Fast feature issues required
- Possibility of gradual scaling

## Decision
Selected module monolith as main architecture model

## Alternatives Considered
- **Microservices**
 + Pluses: High scaling, independent deployments, technology flexibility
 - Minuses: Serious expenses on DevOps, infrastructure complication, increasing requirements to the team
### Pros
- High scaling
- independent deployments
- technology flexibility

### Cons
- Serious expenses on DevOps
- infrastructure complication 
- increasing requirements to the team

## Consequences
### Pros
- Simplified support
- Less DevOps load
- Fast start of the development
- Simple infrastructure

### Cons
- Limited scaling with increasing load
- Risk of complication module borders inside the monolith
- Possible challenges with migration to microservices in future

## Technical Impact
- CI/CD will be easier: single pipeline for the whole application
- Logging and monitoring centralized
- Limited flexibility in technology selection (single stack)

## Diagram Validation

All C4 diagrams must be validated before merging:
- Local check: `make check-diagrams`
- Rendering: `make render-diagrams`
- CI gate: every PR runs `make check-diagrams`. Failure = red PR.

## Next Steps
- Define module boundaries inside the monolith
- Configure CI/CD pipeline and monitoring setup
- Specify and document criteria for decision revision (e.g, team growing > 15 developers, or load > X requests/sec)

## Related ADRs
- [ADR-0001: Non-functional requirements (SLO/SLI)](../adr/0001-non-functional-requirements.md)
- [ADR-0002: BOTEC calculations](../adr/0002-BOTEC-calculations.md)
