# Capacity plan

## Entry data (from [ADR-0002](../adr/0002-BOTEC-calculations.md))
- RPS_avg: ~ 4.6
- RPS_peak: ~ 18.5
- Latency target(p95): 300 ms
- Concurrency: 18.5 * 0.3 = ~ 5.5 requests

## Growing scenarios

### S1: common grow x3 per year
- RPS_peak = 18.5 * 3 = 55.5
- Concurrency (normal) = 55.5 * 0.3 = ~ 16.7 requests
- Concurrency (degrade, latency x5 = 1.5 s) = 55 * 1.5 = ~ 83.3 requests

### S2: marketing spike x10 per 2 days
- RPS_peak = 18.5 * 10 = 185
- Concurrency (normal) = 185 * 0.3 = ~ 55.5 requests
- Concurrency (degrade, latency x5 = 1.5 s) = 185 * 1.5 = ~ 277.5 requests

### S3: unexpected regress (latency x5)
- RPS_peak = 18.5 (doesn't change)
- Concurrency (normal) = 18.5 * 0.3 = ~ 5.5 requests
- Concurrency (degrade) = 18.5 * 1.5 = ~ 27.8 requests

## Table Headroom (goal: +30%)

| Scenario     | RPS_peak | Latency (sec) | Concurrency | Headroom Target (x1.3) |
|--------------|----------|---------------|-------------|------------------------|
| S1 (normal)  | 55.5     | 0.3           | 16.7        | ~ 21.7                 |
| s1 (degrade) | 55.5     | 1.5           | 83.3        | ~ 108.3                |
| S2 (normal)  | 185      | 0.3           | 55.5        | ~ 72.2                 |
| s2 (degrade) | 185      | 1.5           | 277.5       | ~ 360.8                |
| S3 (normal)  | 18.5     | 0.3           | 5.5         | ~ 7.2                  |
| s3 (degrade) | 18.5     | 1.5           | 27.8        | ~ 36.1                 |

## Conclusion: Scale-up vs Scale-out

1. **S1 (grow x3)**: Load grows gradually → decision: scale-out (horizontal scaling) to spread requests and keep headroom
2. **S2 (spike x10)**: Short-term peak → decision: auto-scale-out (elastic scaling in cloud/Kubernetes), better than keeping powerful nodes constantly
3. **S3 (latency x5)**: Problem is not RPS but latency → decision: scale-up (increasing recourses per node, timeout optimization, connection pooling)
4. Redis becomes the main bottleneck with high hit-ratio → plan for Redis cluster/replica scaling
5. Database is protected by cache (~1.85 RPS), but Redis must handle dozens-hundreds of RPS during spikes
6. For normal load, a common cluster with 30% capacity headroom is sufficient
7. For spikes elastic scaling policies (HPA/VPA) are critical
8. Monitoring headroom and reviewing strategy every 3 - 6 months is required