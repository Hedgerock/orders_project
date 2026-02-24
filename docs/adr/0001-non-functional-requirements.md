# ADR-0001: Non-functional requirements (SLO/SLI)

- Status: Accepted
- Date: 2026-02-22
- Owners: Backend Team

## Requirements

- **Availability**:
  - Availability_value: 99.95% (~22 minutes)
  - Definition: Impossible to work with order through the API
  - Measurement: Synthetic probes + error metrics
  
- **Latency**:
  - p95: <= 300ms on API CreateOrder
  - p99: <= 800ms
  - Measurement: Histogram in Prometheus, aggregation through the cluster
  
- **Reliability**:
  - MTBF: >= 30 days
  - Method: Failure during peak hours must not reduce availability below SLA
  
- **Maintainability**:
  - MTTR: <= 30 minutes
  - Practices: Feature flags, rollback, automatized tests
  
- **Scalability**:
  - Definition: System must scale to 5x current load within 2 years
  - Method: Horizontal scaling API and queues
  
- **Observability**:
  - Definition: All key actions must be logged and metrics collected
  - Method: Structured logging + tracing
  - Latency measurement points:
    - Edge/Gateway -> defines SLO (user-facing latency)
    - Inside service -> diagnostic metrics (DB queries, external calls)
  - PromQL Example:
  ```promql
  histogram_quantile(0.95, sum(rate(http_request_duration_seconds_bucket[5m])) by (le))
  ```
  - Cache hit ratio >= 90% (SLO)
  - Eviction count monitored, alert if > threshold
  - Redis latency p95 < 5ms
- **Security**:
  - Definition: All externals calls (Payment Provider) through the TLS, retry with exponential backoff
  - Method: Regular pentests

- **Cost efficiency**:
  - Definition: Infrastructure <= 20% of product budget
  - Method: Monitoring expenses in cloud