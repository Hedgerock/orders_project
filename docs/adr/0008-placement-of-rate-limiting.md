# ADR-0008: Placement of Rate Limiting (Gateway vs. In-Service vs. Dedicated Service)

- Status: Accepted
- Date: 2026-03-02
- Owners: Backend Team

## Context
Rate limiting is required to protect backend services from overload and ensure fair usage. We must decide where to 
enforce it

## Decision
Project implement rate limiting at the gateway, with the option to extend to a dedicated RL service for advanced 
scenarios

## Trade-offs
- **Gateway**:
  - Pros:
    - Centralized control
    - Immediate protection
    - Simple to configure
  - Cons:
    - Less granular per-service logic
    - Gateway becomes critical dependency
- **In-Service**:
   - Pros:
     - Fina-grained control per endpoint
     - Service-specific policies
   - Cons:
     - Duplicated logic across services
     - Harder to maintain consistency
- **Dedicated RL Service**:
  - Pros:
    - Flexible
    - Reusable across multiple gateways/services
    - advanced algorithms possible
  - Cons:
    - Extra latency hop
    - Additional infrastructure component
    - More complexity

## Consequences
- Gateway RL covers most traffic scenarios with minimal overhead
- For complex multi-tenant or per-user policies, a dedicated RL service can be introduced later
- In-service RL avoided to reduce duplication and maintenance burden