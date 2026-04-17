# Interview Notes

## Positioning

This solution starts with a reproducible local Kubernetes deployment and then adds the controls I would want before handing it to a team: safer defaults, observability hooks, rollback-friendly deployments, and clearer documentation.

## Main points to say

- I focused on security, operability, reliability, and maintainability because those are explicitly called out in the assignment.
- I kept the first version Kustomize-native to avoid over-engineering.
- I added Helm and CI in the upgraded version to show how the same solution scales to team ownership.
- I called out further steps like mTLS, image signing, admission policies, and secret management as future work rather than pretending the local setup is fully production complete.
