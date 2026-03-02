# Target strategy
- Use HPA for gateway and core API services
- Define special scaling rules for background workers
- Incorporate not only CPU metrics but also additional signals:
  - RPS per route (via Prometheus custom metrics)
  - Queue length / consumer lag (for workers)

  - p95 latency as guarded signal - handled through alert/predicates, not direct scaling rules

## Principles
- Gateway and core API scale based on CPU usage and RPS
- Workers scale based on queue length
- Latency acts as en extra safeguard: if p95 grows, an alert is triggered and a manual check is performed