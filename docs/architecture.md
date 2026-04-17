# Architecture Diagram

```mermaid
flowchart LR
    client[Client / API Consumer] --> ingress[Ingress: payments.local]
    ingress --> gwsvc[ClusterIP Service\npayment-gateway:8080]
    gwsvc --> gwpods[Deployment\npayment-gateway replicas]
    gwpods -->|PAYMENT_PROCESSOR_URL| prosvc[ClusterIP Service\npayment-processor:8080]
    prosvc --> propods[Deployment\npayment-processor replicas]

    prom[Prometheus] -->|scrapes /metrics| gwsvc
    prom -->|scrapes /metrics| prosvc

    netpol[NetworkPolicy] -. allows only required traffic .-> gwpods
    netpol -. allows only required traffic .-> propods

    sa[Dedicated ServiceAccounts] --> gwpods
    sa --> propods
    cfg[ConfigMap] --> gwpods
```

## Flow

1. Client traffic enters through local ingress or port-forward to `payment-gateway`.
2. The gateway forwards payment requests to `payment-processor` using internal Kubernetes service discovery.
3. Both services expose health and Prometheus metrics endpoints.
4. Prometheus scrapes metrics for dashboards and alerting.
5. Network policies and hardened pod security settings reduce exposure and limit blast radius.
