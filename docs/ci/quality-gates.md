# CI Quality Gates

## Diagram Validation
- All PlantUML diagrams must pass `plantuml -checkonly`
- Ensures syntax correctness and prevents broken diagrams in docs
- All Kubernetes YAML manifests must pass `yamllint` or `kubeconform`
- Rules:
  - No syntax errors
  - Consistent indentation
  - Valid against Kubernetes schemas (kubeconform)

## Kubernetes Checks
- `make check-k8s` runs YAML validation
- Included in goal `make check`

## Integration
- CI pipeline runs `make check` on every PR
- Failures block merge until corrected