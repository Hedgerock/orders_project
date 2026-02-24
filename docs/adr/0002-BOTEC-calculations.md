# ADR-0002: BOTEC calculations

- Status: Accepted
- Date: 2026-02-22
- Owners: Backend Team

## Entry data

 - DAU: 2_000_000
 - Actions per user/day: 0.2
 - Total orders: 2_000_000 * 0.2 ~ 400_000 orders/day
 - Peak load share: 80%
 - Peak duration: 4.8 hours/day
 - Latency target (p95): 300ms (from ADR-0001)
 - Answer payload size: 2 KB

## Calculations

- **RPS_avg**:
  - Formula: Total orders / 86400 (seconds/day)
  - Calculation: 400_000 / 86400
  - Result: ~ 4.6 RPS

- **RPS_peak**:
  - Formula: RPS_peak = (Total orders * Peak share) / (Peak duration * 3600)
  - Calculation: (400_000 * 0.8) / (4.8 * 3600) ~ 18.5 RPS
  - Result: ~ 18.5 RPS

- **Concurrency**:
  - Formula: RPS_peak * p95_latency
  - Calculation: 18.5 * 0.3
  - Result: ~ 5.5 simultaneous requests
  - Note: This is worst-case concurrency (p95), not average

- **Traffic egress/ingress**:
  - Formula: RPS_peak * Answer size
  - Calculation: 18.5 * 2000
  - Result: ~ 37 KB/s
  - Equivalent: ~ 0.3 Mbps (~ 0.0003 Gbps)
  - Conclusion: Network load negligible compared to typical 1 Gbps link\

## Cache impact (from ADR-0004)

- Assumed cache hit ratio: 90%
- **Effective DB RPS_peak**:
  - Formula: RPS_peak * (1 - hit_ratio)
  - Calculation: 18.5 * (1 - 0.9) = ~ 1.85 RPS
- **Effective Redis RPS_peak**:
  - Formula: RPS_peak * heat_ratio
  - Calculation: 18.5 * 0.9 = ~ 16.65 RPS
- **Conclusion**: Database load reduced ~10xd at peak, Redis must handle the majority of read traffic