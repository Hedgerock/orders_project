# Decisions

## Web UI (React SPA)

### Three key responsibilities
1. Interface visualization and user interaction
2. Creating and sending requests to the API through the LB/Gateway
3. Collecting and sending client metrics (UX latency, JS errors) to Observability

### Two risks/compromises:
1. Dependency on browser and network: with high latency from the provider, UX will degrade even if backend is working well
2. Complexity of versioning and caching: frontend updates can conflict with API contracts, if strict synchronization is absent

## L7 Load Balancer / Ingress

### Three key responsibilities
1. Receiving incoming HTTPS traffic and performing SSL termination
2. Load balancing between Gateway/API instances
3. Basic perimeter protection mechanisms (firewall rules, DDoS mitigation)

### Two risks/compromises:
1. Can become a single point of failure, if clustering/HA is not configured
2. Limited capabilities at the L4/L7 level - complex policies are better implemented in the Gateway

## API Gateway

### Three key responsibilities
1. Request routing to required services and API versions
2. Authentication and authorization, quotas, basic rate limiting
3. Integration with observability: metrics, logs, traces

### Two risks/compromises:
1. Extra delay (latency budget) per request
2. Configuration complexity and risk of vendor lock-in when choosing a specific solution

## Redis Limiter (Redis-backed)

### Three key responsibilities
1. Restricting request frequency by keys (user, apiKey, route)
2. Protection against traffic abuse or sudden spikes
3. Storing state limits in Redis to ensure consistency across instances

### Two risks/compromises:
1. If Redis becomes unavailable, a choice must be made between fail-open and fail-close - both options are risky
2. Configuration complexity across different criteria (global, per-user, per-route) while avoiding excessive load