# Kubernetes Deployment

This directory contains all Kubernetes manifests required to deploy the **ABC-Technologies** application.

The deployment follows Kubernetes best practices and is designed to work with the existing cluster infrastructure, including:

- Kubernetes v1.29+
- NGINX Ingress Controller
- MetalLB
- Istio Service Mesh
- Prometheus Monitoring
- Grafana
- Horizontal Pod Autoscaler (HPA)

---

# Directory Structure

```text
kubernetes/

├── namespace.yaml
├── configmap.yaml
├── serviceaccount.yaml
├── networkpolicy.yaml
├── deployment.yaml
├── service.yaml
├── ingress.yaml
├── servicemonitor.yaml
├── hpa.yaml
├── kustomization.yaml
└── README.md
```

---

# Kubernetes Resources

| File | Purpose |
|------|---------|
| namespace.yaml | Creates the application namespace |
| configmap.yaml | Stores non-sensitive application configuration |
| serviceaccount.yaml | Creates a dedicated ServiceAccount |
| networkpolicy.yaml | Restricts network traffic |
| deployment.yaml | Deploys application pods |
| service.yaml | Exposes the application inside the cluster |
| ingress.yaml | Publishes the application through NGINX Ingress |
| servicemonitor.yaml | Enables Prometheus metrics scraping |
| hpa.yaml | Automatically scales application pods |
| kustomization.yaml | Deploys all resources together |

---

# Deployment Order

Resources are applied in the following order:

```text
Namespace

↓

ConfigMap

↓

ServiceAccount

↓

NetworkPolicy

↓

Deployment

↓

Service

↓

Ingress

↓

ServiceMonitor

↓

Horizontal Pod Autoscaler
```

---

# Deploy Using Kustomize

Deploy everything with:

```bash
kubectl apply -k kubernetes/
```

---

# Verify Deployment

Check all resources

```bash
kubectl get all -n abc-technologies
```

---

Check pods

```bash
kubectl get pods -n abc-technologies
```

---

Check deployment

```bash
kubectl get deployment -n abc-technologies
```

---

Check service

```bash
kubectl get svc -n abc-technologies
```

---

Check ingress

```bash
kubectl get ingress -n abc-technologies
```

---

Check HPA

```bash
kubectl get hpa -n abc-technologies
```

---

Check ServiceMonitor

```bash
kubectl get servicemonitor -n monitoring
```

---

# Rollout Status

```bash
kubectl rollout status deployment/abc-technologies \
-n abc-technologies
```

---

# Rollback

```bash
kubectl rollout undo deployment/abc-technologies \
-n abc-technologies
```

---

# Application URL

```
https://abc.192.168.56.100.nip.io
```

---

# Monitoring

Prometheus automatically discovers the application using the ServiceMonitor.

Verify Prometheus target

```bash
kubectl get servicemonitor -n monitoring
```

Grafana dashboards can then be used to monitor:

- CPU Usage
- Memory Usage
- Pod Status
- Request Rate
- Response Time
- Error Rate

---

# Scaling

The Horizontal Pod Autoscaler automatically adjusts the number of replicas based on CPU utilization.

View HPA status

```bash
kubectl get hpa -n abc-technologies
```

---

# Security Features

This deployment includes:

- Dedicated Namespace
- Dedicated ServiceAccount
- NetworkPolicy
- Resource Requests
- Resource Limits
- Liveness Probe
- Readiness Probe
- Rolling Updates
- Rolling Rollback
- ConfigMap-based configuration

---

# Notes

- Deployment is performed using **Ansible (`deploy.yml`)**.
- Kubernetes manifests are managed with **Kustomize**.
- Jenkins orchestrates the deployment pipeline.
- NGINX Ingress exposes the application externally.
- Prometheus and Grafana provide monitoring.
- Istio integration is available through namespace labeling.

---

# Summary

This directory provides a complete Kubernetes deployment for the **ABC-Technologies** application using production-inspired Kubernetes practices, Infrastructure as Code (IaC), and automated deployment through Ansible.