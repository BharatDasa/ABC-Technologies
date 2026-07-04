# Project Flow

## Overview

ABC-Technologies follows a complete Enterprise CI/CD workflow, starting from source code commit and ending with a production deployment on Kubernetes.

The project demonstrates modern DevOps practices using GitHub, Jenkins, Maven, SonarQube, Nexus, Trivy, Docker, Kubernetes, Istio, Prometheus, Grafana, and Ansible.

---

# End-to-End Workflow

```
Developer

    │

    ▼

GitHub Repository

    │

    ▼

Webhook Trigger

    │

    ▼

Jenkins Pipeline

    │

    ├──────────────► Checkout Source Code
    │
    ├──────────────► Auto Fix Environment
    │
    ├──────────────► Static Code Analysis
    │
    ├──────────────► Unit Testing
    │
    ├──────────────► Build WAR
    │
    ├──────────────► SonarQube Analysis
    │
    ├──────────────► Quality Gate
    │
    ├──────────────► Publish Artifact to Nexus
    │
    ├──────────────► Build Docker Image (Kaniko)
    │
    ├──────────────► Vulnerability Scan (Trivy)
    │
    ├──────────────► Push Image to Docker Registry
    │
    ├──────────────► Deploy using Kustomize
    │
    ├──────────────► Verify Deployment
    │
    ├──────────────► Health Validation
    │
    └──────────────► Deployment Complete

    │

    ▼

Kubernetes Cluster

    │

    ▼

Namespace

    │

    ▼

Deployment

    │

    ▼

ReplicaSet

    │

    ▼

Pods

    │

    ▼

Service

    │

    ▼

Ingress

    │

    ▼

Users

```

---

# Stage 1 — Source Code

The application source code is maintained in GitHub.

Repository contains

- Java Source Code
- Kubernetes Manifests
- Jenkins Pipeline
- Dockerfile
- Ansible Playbooks
- Documentation

---

# Stage 2 — GitHub Webhook

Whenever code is pushed,

GitHub automatically sends a webhook to Jenkins.

```
Developer

↓

Git Push

↓

GitHub

↓

Webhook

↓

Jenkins
```

No manual deployment is required.

---

# Stage 3 — Jenkins Pipeline

Jenkins creates a dynamic Kubernetes agent.

Pipeline containers include

- JNLP
- Maven
- Kaniko
- Trivy
- Ansible

Every build runs in a fresh Kubernetes Pod.

Benefits

- Clean environment
- Faster builds
- Better scalability
- No dependency conflicts

---

# Stage 4 — Source Checkout

Jenkins clones the latest source code.

```
git clone

↓

Workspace Created

↓

Pipeline Starts
```

---

# Stage 5 — Auto Fix Environment

Before deployment,

Ansible validates the Kubernetes environment.

Checks include

- kubectl availability
- kubeconfig
- Namespace
- Required directories
- Cluster connectivity

If the namespace does not exist,

it is created automatically.

---

# Stage 6 — Static Code Analysis

The Java source code is validated.

Typical checks

- Syntax
- Formatting
- Warnings
- Code Quality

Purpose

Detect issues before compilation.

---

# Stage 7 — Unit Testing

JUnit executes automated tests.

Example

```
mvn test
```

Benefits

- Validate business logic
- Catch regressions
- Increase confidence

---

# Stage 8 — Build

Maven packages the application.

```
mvn clean package
```

Output

```
ABCtechnologies.war
```

---

# Stage 9 — SonarQube Analysis

Source code is analyzed for

- Bugs
- Vulnerabilities
- Code Smells
- Coverage
- Maintainability

Pipeline submits results to SonarQube.

---

# Stage 10 — Quality Gate

SonarQube Quality Gate determines whether deployment can continue.

```
PASS

↓

Continue Deployment

```

or

```
FAIL

↓

Pipeline Stops
```

This prevents low-quality code from reaching production.

---

# Stage 11 — Publish Artifact

The WAR file is uploaded to Nexus.

```
Jenkins

↓

Nexus

↓

Artifact Repository
```

Benefits

- Versioning
- Rollback
- Central storage

---

# Stage 12 — Docker Image Build

Kaniko builds the Docker image inside Kubernetes.

```
WAR

↓

Dockerfile

↓

Container Image
```

Kaniko does not require Docker daemon.

---

# Stage 13 — Vulnerability Scan

Trivy scans the image.

Checks include

- CVEs
- High vulnerabilities
- Critical vulnerabilities
- OS packages
- Java libraries

Pipeline can fail if critical issues are found.

---

# Stage 14 — Push Image

After validation,

the image is pushed to the container registry.

Example

```
registry/project

↓

abc-technologies:v26
```

---

# Stage 15 — Kubernetes Deployment

Jenkins executes

```
kubectl apply -k kubernetes/
```

Kustomize deploys

- Namespace
- ConfigMap
- ServiceAccount
- Deployment
- Service
- Ingress
- HPA
- NetworkPolicy
- ServiceMonitor

---

# Stage 16 — Scheduling

Kubernetes Scheduler selects an appropriate node.

Application workloads are scheduled onto

```
k8s-worker2
```

Infrastructure workloads remain on

```
k8s-worker1
```

---

# Stage 17 — Deployment

Deployment creates

```
Deployment

↓

ReplicaSet

↓

Pods
```

Pods are started automatically.

---

# Stage 18 — Service

A ClusterIP Service exposes the application internally.

```
Pods

↓

ClusterIP

↓

Ingress
```

---

# Stage 19 — Ingress

NGINX Ingress provides external access.

```
Internet

↓

NGINX

↓

Service

↓

Pods
```

---

# Stage 20 — Istio

Each Pod receives an Envoy sidecar.

```
Application

+

Envoy Proxy
```

Istio provides

- Traffic Management
- mTLS
- Telemetry
- Metrics
- Tracing

---

# Stage 21 — Prometheus

Prometheus discovers the application using a ServiceMonitor.

```
Prometheus

↓

ServiceMonitor

↓

Service

↓

Pods

↓

Istio Sidecar
```

Metrics are collected continuously.

---

# Stage 22 — Grafana

Grafana visualizes Prometheus metrics.

Dashboards display

- CPU Usage
- Memory Usage
- Pod Count
- Response Time
- Request Rate
- Error Rate

---

# Stage 23 — Horizontal Pod Autoscaler

HPA continuously watches resource utilization.

Example

```
CPU > Target

↓

Scale Out

↓

More Pods

↓

Traffic Balanced
```

When load decreases,

pods are automatically removed.

---

# Stage 24 — Self-Healing

If a Pod crashes,

Kubernetes automatically creates another.

```
Pod Failure

↓

ReplicaSet Detects Failure

↓

New Pod Created

↓

Application Restored
```

No manual intervention is required.

---

# Stage 25 — Rolling Updates

During deployment,

new Pods are created first.

```
Old Pod

↓

New Pod

↓

Health Check

↓

Traffic Shift

↓

Old Pod Removed
```

Benefits

- Zero downtime
- Safe deployment
- Easy rollback

---

# Stage 26 — Monitoring

The platform continuously monitors

- Pods
- Nodes
- CPU
- Memory
- Network
- Kubernetes Components
- Application Metrics
- Istio Metrics

---

# Stage 27 — Logging

Application and container logs are collected.

Logs can be viewed using

```bash
kubectl logs
```

or centralized logging platforms.

---

# Stage 28 — Security

Security controls include

- Namespace Isolation
- Service Accounts
- RBAC
- Network Policies
- Resource Limits
- Image Scanning
- Istio mTLS Ready
- Declarative Infrastructure

---

# Deployment Verification

Verify namespace

```bash
kubectl get ns
```

Verify deployment

```bash
kubectl get deployment \
-n abc-technologies
```

Verify pods

```bash
kubectl get pods \
-o wide \
-n abc-technologies
```

Verify service

```bash
kubectl get svc \
-n abc-technologies
```

Verify ingress

```bash
kubectl get ingress \
-n abc-technologies
```

Verify HPA

```bash
kubectl get hpa \
-n abc-technologies
```

Verify ServiceMonitor

```bash
kubectl get servicemonitor -A
```

Verify rollout

```bash
kubectl rollout status deployment \
abc-technologies \
-n abc-technologies
```

---

# Complete Enterprise Flow

```
Developer

↓

GitHub

↓

Webhook

↓

Jenkins

↓

Auto Fix

↓

Build

↓

Unit Test

↓

SonarQube

↓

Quality Gate

↓

Nexus

↓

Kaniko

↓

Trivy

↓

Container Registry

↓

Kustomize

↓

Kubernetes

↓

Deployment

↓

ReplicaSet

↓

Pods

↓

Service

↓

Ingress

↓

Istio

↓

Prometheus

↓

Grafana

↓

Users
```

---

# Technologies Used

| Category | Technology |
|----------|------------|
| Source Control | GitHub |
| CI/CD | Jenkins |
| Build Tool | Maven |
| Code Quality | SonarQube |
| Artifact Repository | Nexus |
| Image Builder | Kaniko |
| Security Scanner | Trivy |
| Configuration Management | Ansible |
| Container Runtime | Docker |
| Orchestration | Kubernetes |
| Service Mesh | Istio |
| Monitoring | Prometheus |
| Visualization | Grafana |
| Autoscaling | HPA |
| Networking | NetworkPolicy |
| Deployment Management | Kustomize |

---

# Key Features

- Fully Automated CI/CD
- Dynamic Jenkins Agents
- Infrastructure as Code
- Kubernetes Native Deployment
- Service Mesh Integration
- Automatic Scaling
- Self-Healing
- Zero Downtime Deployment
- Enterprise Security
- Continuous Monitoring
- Production-ready Architecture

---

# Author

**Project:** ABC-Technologies

**Maintainer:** Bharat Dasa