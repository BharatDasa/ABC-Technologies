# ABC-Technologies Deployment Guide

## Overview

This document describes the deployment process for the ABC-Technologies application.

The application is deployed using a fully automated CI/CD pipeline built with:

- Git
- Jenkins
- Maven
- SonarQube
- JaCoCo
- Nexus
- Docker
- Trivy
- Ansible
- Kubernetes
- Istio
- Prometheus
- Grafana

The deployment process follows production-grade DevSecOps practices.

---

# Deployment Workflow

```
Developer

    │

    ▼

Git Push

    │

    ▼

Jenkins Pipeline

    │

    ▼

Build

    │

    ▼

Test

    │

    ▼

Code Quality

    │

    ▼

Publish Artifact

    │

    ▼

Build Docker Image

    │

    ▼

Security Scan

    │

    ▼

Push Image

    │

    ▼

Deploy to Kubernetes

    │

    ▼

Health Validation

    │

    ▼

Production
```

---

# Prerequisites

The following components must already be installed.

| Component | Version |
|-----------|---------|
| Java | 17+ |
| Maven | 3.9+ |
| Docker | Latest |
| Kubernetes | 1.29+ |
| kubectl | Latest |
| Jenkins | Latest |
| Ansible | Latest |
| Git | Latest |

---

# Repository Structure

```
ABC-Technologies/

├── ansible/
├── docker/
├── docs/
├── jenkins/
├── kubernetes/
├── scripts/
├── src/
├── pom.xml
└── README.md
```

---

# Build Application

Compile the project.

```bash
mvn clean package
```

Skip tests if required.

```bash
mvn clean package -DskipTests
```

---

# Run Unit Tests

```bash
mvn test
```

Generate code coverage.

```bash
mvn verify
```

---

# Publish Artifact

Deploy the WAR file to Nexus.

```bash
mvn clean deploy \
-U \
-Drevision=1.0.0 \
-Dchangelist=
```

---

# Build Docker Image

```bash
docker build \
-t abc-technologies:1.0.0 \
-f docker/Dockerfile .
```

---

# Run Docker Container

```bash
docker run \
-p 8080:8080 \
abc-technologies:1.0.0
```

Verify application.

```bash
curl http://localhost:8080/
```

---

# Push Docker Image

```bash
docker tag abc-technologies:1.0.0 \
<registry>/abc-technologies:1.0.0

docker push \
<registry>/abc-technologies:1.0.0
```

---

# Deploy to Kubernetes

Deploy all manifests.

```bash
kubectl apply -k kubernetes/
```

Verify resources.

```bash
kubectl get all \
-n abc-technologies
```

---

# Verify Namespace

```bash
kubectl get namespace
```

---

# Verify Deployment

```bash
kubectl get deployment \
-n abc-technologies
```

Describe deployment.

```bash
kubectl describe deployment \
abc-technologies \
-n abc-technologies
```

---

# Verify Pods

```bash
kubectl get pods \
-n abc-technologies
```

Detailed output.

```bash
kubectl get pods \
-o wide \
-n abc-technologies
```

Describe pod.

```bash
kubectl describe pod <pod-name> \
-n abc-technologies
```

---

# Verify Service

```bash
kubectl get svc \
-n abc-technologies
```

Describe service.

```bash
kubectl describe svc \
abc-technologies \
-n abc-technologies
```

---

# Verify Ingress

```bash
kubectl get ingress \
-n abc-technologies
```

---

# Verify HPA

```bash
kubectl get hpa \
-n abc-technologies
```

Describe HPA.

```bash
kubectl describe hpa \
abc-technologies \
-n abc-technologies
```

---

# Verify ServiceMonitor

```bash
kubectl get servicemonitor \
-A
```

Describe ServiceMonitor.

```bash
kubectl describe servicemonitor \
abc-technologies \
-n abc-technologies
```

---

# Verify Network Policy

```bash
kubectl get networkpolicy \
-n abc-technologies
```

Describe Network Policy.

```bash
kubectl describe networkpolicy \
abc-technologies-network-policy \
-n abc-technologies
```

---

# Verify Application

Application home page.

```bash
curl http://localhost:8080/
```

Application inside Kubernetes.

```bash
kubectl exec -it deployment/abc-technologies \
-n abc-technologies \
-c abc-technologies -- \
wget -qO- http://localhost:8080/
```

---

# Verify Metrics Endpoint

```bash
kubectl exec -it deployment/abc-technologies \
-n abc-technologies \
-c istio-proxy -- \
curl http://localhost:15090/stats/prometheus
```

---

# Verify Prometheus Connectivity

```bash
kubectl exec -it \
prometheus-monitoring-kube-prometheus-prometheus-0 \
-n monitoring \
-c prometheus -- sh
```

Inside the Prometheus container.

```sh
wget -qO- \
http://<pod-ip>:15090/stats/prometheus | head
```

---

# Verify Grafana

Open Grafana.

```
http://<grafana-url>
```

Navigate to:

```
Dashboards
```

Verify application metrics.

---

# View Logs

Application logs.

```bash
kubectl logs deployment/abc-technologies \
-n abc-technologies \
-c abc-technologies
```

Istio logs.

```bash
kubectl logs deployment/abc-technologies \
-n abc-technologies \
-c istio-proxy
```

---

# Rolling Restart

```bash
kubectl rollout restart deployment \
abc-technologies \
-n abc-technologies
```

Check rollout status.

```bash
kubectl rollout status deployment \
abc-technologies \
-n abc-technologies
```

---

# Rollback

View rollout history.

```bash
kubectl rollout history deployment \
abc-technologies \
-n abc-technologies
```

Rollback to previous revision.

```bash
kubectl rollout undo deployment \
abc-technologies \
-n abc-technologies
```

---

# Scale Application

Manual scaling.

```bash
kubectl scale deployment \
abc-technologies \
--replicas=4 \
-n abc-technologies
```

Verify.

```bash
kubectl get pods \
-n abc-technologies
```

---

# Clean Up

Delete deployment.

```bash
kubectl delete -k kubernetes/
```

Delete namespace.

```bash
kubectl delete namespace abc-technologies
```

---

# Troubleshooting

## Pod Pending

Check events.

```bash
kubectl describe pod <pod-name>
```

---

## Image Pull Error

Verify image.

```bash
kubectl describe pod <pod-name>
```

---

## CrashLoopBackOff

View logs.

```bash
kubectl logs <pod-name>
```

---

## Service Not Reachable

Verify.

```bash
kubectl get svc
kubectl get endpoints
```

---

## Prometheus Target Down

Verify.

```bash
kubectl get servicemonitor -A

kubectl get endpoints \
-n abc-technologies

kubectl exec -it \
prometheus-monitoring-kube-prometheus-prometheus-0 \
-n monitoring \
-c prometheus -- sh
```

---

## Jenkins Deployment Failure

Check pipeline logs.

Verify:

- Git Checkout
- Maven Build
- SonarQube Analysis
- Nexus Upload
- Docker Build
- Trivy Scan
- Docker Push
- Kubernetes Deployment

---

# Deployment Strategy

The application uses:

- Rolling Updates
- Readiness Probe
- Liveness Probe
- Startup Probe
- Graceful Shutdown
- Horizontal Pod Autoscaler
- Network Policies
- Istio Sidecar Injection
- Prometheus Monitoring

This ensures zero-downtime deployments.

---

# Success Criteria

Deployment is considered successful when:

- All Pods are Running
- All Containers are Ready
- Deployment is Available
- Service is Reachable
- Ingress is Active
- Prometheus Targets are UP
- Grafana Displays Metrics
- HPA is Active
- No Critical Events
- No Failed Pods

---

# Author

**Project:** ABC-Technologies

**Deployment Model:** Enterprise Kubernetes DevSecOps

**Maintainer:** Bharat Dasa