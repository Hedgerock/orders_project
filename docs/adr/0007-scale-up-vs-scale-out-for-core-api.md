# ADR-0007: Scale-Up vs Scale-Out for Core API (12-Month Horizon)

- Status: Accepted
- Date: 2026-03-02
- Owners: Backend Team

## Context
The Core API is expected to face increased traffic over the next year. We need to decide whether to handle growth by
scaling up (larger instances) or scaling out (more replicas)

## Decision
We will prioritize scale-out (horizontal scaling) for the Core API

## Trade-offs
- **Scale-Up (vertical)**
  - Pros: 
    - Simpler operations 
    - Fewer nodes 
    - Reduced coordination overhead
  - Cons: 
    - Hardware limits reached quickly 
    - Single point of failure 
    - Cost spikes for high-end machines
- **Scale-Out (horizontal)**
  - Pros:
    - Better fault tolerance
    - Elasticity
    - Aligns with Kubernetes HPA/VPA
    - Easier to distribute load
  - Cons:
    - Requires robust load balancing
    - More complex monitoring
    - potential consistently challenges

## Consequences
- Infrastructure costs spread across commodity nodes
- Operational complexity increases (more replicas to manage)
- Enable gradual growth without hitting hardware ceilings

## Related documents
- [Rate limiter](../edge/rate-limiter.md)