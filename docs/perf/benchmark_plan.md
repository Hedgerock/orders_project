# Benchmark Plan

**1.Load Profile (Stepwise)**
- Start at 25% of RPS_peak
- Increase to 50% → 75% → 100% of RPS_peak
- Then stress scenarios:
  - x3 RPS_peak
  - x10 RPS_peak
- Each step sustained long enough to reach steady-state metrics (e.g., 5-10 minutes per level)

**2.Open Model**
- Use an open workload model: the generator issues requests at the defined rate regardless of system response
- Ensures the system under test is the bottleneck, not the load generator
- prevents artificial throttling and allows observation of saturation behavior

**3.Metrics to capture**
- Latency:
  - p95 and p99 for Gateway
  - p95 and p99 for Core Service
- Error Rate:
  - 4xx errors (client-side issues)
  - 5xx errors (server-side failures)
- Saturation Indicators
  - Active connections at Gateway
  - Queue lengths (e.g., worker queues, message brokers)
  - Pool utilization (DB connection pools, thread pools)