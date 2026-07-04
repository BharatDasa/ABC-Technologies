# Screenshots

## Overview

This document contains recommended screenshots for the ABC-Technologies project.

These screenshots demonstrate the complete CI/CD pipeline, Kubernetes deployment, monitoring, security, and application functionality.

> **Note:** Update the image paths after adding screenshots to the repository.

---

# Repository Structure

Store all screenshots under:

```
docs/

└── screenshots/

    ├── github/
    ├── jenkins/
    ├── nexus/
    ├── docker/
    ├── kubernetes/
    ├── istio/
    ├── prometheus/
    ├── grafana/
    ├── trivy/
    ├── ansible/
    └── application/
```

---

# GitHub

## Repository

Shows the complete project repository.

```
docs/screenshots/github/repository.png
```

Example

```text
ABC-Technologies Repository
```

---

## Branches

```
docs/screenshots/github/branches.png
```

---

## Commit History

```
docs/screenshots/github/commits.png
```

---

## Pull Request

(Optional)

```
docs/screenshots/github/pull-request.png
```

---

# Jenkins

## Dashboard

```
docs/screenshots/jenkins/dashboard.png
```

Shows

- Jobs
- Build History
- Status

---

## Pipeline

```
docs/screenshots/jenkins/pipeline.png
```

Shows

```
Checkout

↓

Auto Fix

↓

Build

↓

Unit Test

↓

Sonar

↓

Quality Gate

↓

Nexus

↓

Kaniko

↓

Trivy

↓

Deploy

↓

Verify
```

---

## Console Output

```
docs/screenshots/jenkins/console-output.png
```

---

## Successful Build

```
docs/screenshots/jenkins/build-success.png
```

---

# SonarQube

## Dashboard

```
docs/screenshots/sonarqube/dashboard.png
```

---

## Quality Gate

```
docs/screenshots/sonarqube/quality-gate.png
```

---

## Code Coverage

```
docs/screenshots/sonarqube/coverage.png
```

---

## Issues

```
docs/screenshots/sonarqube/issues.png
```

---

# Nexus

## Artifact Repository

```
docs/screenshots/nexus/repository.png
```

---

## WAR Artifact

```
docs/screenshots/nexus/war.png
```

---

# Docker

## Docker Registry

```
docs/screenshots/docker/images.png
```

---

## Image Tags

```
docs/screenshots/docker/tags.png
```

---

# Kubernetes

## Cluster Nodes

```
docs/screenshots/kubernetes/nodes.png
```

Example

```bash
kubectl get nodes -o wide
```

---

## Namespaces

```
docs/screenshots/kubernetes/namespaces.png
```

---

## Deployments

```
docs/screenshots/kubernetes/deployments.png
```

---

## Pods

```
docs/screenshots/kubernetes/pods.png
```

---

## Services

```
docs/screenshots/kubernetes/services.png
```

---

## Ingress

```
docs/screenshots/kubernetes/ingress.png
```

---

## HPA

```
docs/screenshots/kubernetes/hpa.png
```

---

## ConfigMap

```
docs/screenshots/kubernetes/configmap.png
```

---

## Service Account

```
docs/screenshots/kubernetes/serviceaccount.png
```

---

## Network Policy

```
docs/screenshots/kubernetes/networkpolicy.png
```

---

## ServiceMonitor

```
docs/screenshots/kubernetes/servicemonitor.png
```

---

## Rolling Update

```
docs/screenshots/kubernetes/rolling-update.png
```

---

# Istio

## Sidecar Injection

```
docs/screenshots/istio/sidecar.png
```

Expected

```
READY

2/2
```

---

## Istio Dashboard

```
docs/screenshots/istio/dashboard.png
```

---

## Kiali

(Optional)

```
docs/screenshots/istio/kiali.png
```

---

# Prometheus

## Targets

```
docs/screenshots/prometheus/targets.png
```

Should show

```
UP
```

---

## Service Discovery

```
docs/screenshots/prometheus/service-discovery.png
```

---

## Query Result

```
docs/screenshots/prometheus/query.png
```

Example

```
up

container_cpu_usage_seconds_total

container_memory_usage_bytes
```

---

# Grafana

## Home Dashboard

```
docs/screenshots/grafana/home.png
```

---

## Kubernetes Dashboard

```
docs/screenshots/grafana/kubernetes.png
```

---

## Node Metrics

```
docs/screenshots/grafana/node.png
```

---

## Pod Metrics

```
docs/screenshots/grafana/pods.png
```

---

## CPU Usage

```
docs/screenshots/grafana/cpu.png
```

---

## Memory Usage

```
docs/screenshots/grafana/memory.png
```

---

## Application Dashboard

```
docs/screenshots/grafana/application.png
```

---

# Trivy

## Vulnerability Scan

```
docs/screenshots/trivy/scan.png
```

---

## Scan Report

```
docs/screenshots/trivy/report.png
```

---

# Ansible

## Auto Fix Playbook

```
docs/screenshots/ansible/auto-fix.png
```

---

## Deployment Playbook

```
docs/screenshots/ansible/deploy.png
```

---

# Application

## Home Page

```
docs/screenshots/application/home.png
```

---

## Login Page

(If applicable)

```
docs/screenshots/application/login.png
```

---

## Product Page

```
docs/screenshots/application/products.png
```

---

## Add Product

```
docs/screenshots/application/add-product.png
```

---

## View Product

```
docs/screenshots/application/view-product.png
```

---

# CI/CD Workflow

Include a screenshot of the complete Jenkins pipeline.

```
docs/screenshots/workflow/pipeline.png
```

---

# Kubernetes Architecture

Include a screenshot or exported diagram showing

```
Internet

↓

Ingress

↓

Service

↓

Pods

↓

Istio

↓

Application
```

```
docs/screenshots/architecture/kubernetes.png
```

---

# Monitoring Architecture

Include

```
Pods

↓

Service

↓

ServiceMonitor

↓

Prometheus

↓

Grafana
```

```
docs/screenshots/architecture/monitoring.png
```

---

# Project Demo

Recommended screenshots for README.md

| Screenshot | Purpose |
|------------|---------|
| GitHub Repository | Source code overview |
| Jenkins Pipeline | CI/CD demonstration |
| SonarQube Dashboard | Code quality |
| Nexus Repository | Artifact storage |
| Kubernetes Pods | Deployment validation |
| Kubernetes Services | Service verification |
| HPA | Autoscaling |
| Prometheus Targets | Monitoring |
| Grafana Dashboard | Visualization |
| Application Home | Final deployed application |

---

# Recommended Capture Order

1. GitHub Repository
2. Jenkins Dashboard
3. Jenkins Pipeline
4. SonarQube
5. Nexus
6. Docker Image
7. Kubernetes Nodes
8. Pods
9. Services
10. Ingress
11. HPA
12. Network Policy
13. ServiceMonitor
14. Istio Sidecar
15. Prometheus Targets
16. Grafana Dashboard
17. Application Home Page

---

# Tips

- Capture screenshots in **dark mode** where possible for consistency.
- Hide any passwords, tokens, or internal secrets before capturing.
- Crop unnecessary browser or terminal areas to keep images focused.
- Use descriptive filenames that match this document.
- Keep all screenshots at a similar resolution for a professional appearance.

---

# Author

**Project:** ABC-Technologies

**Maintainer:** Bharat Dasa