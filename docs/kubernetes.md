# Kubernetes Deployment

## Overview

ABC-Technologies is deployed on a Kubernetes cluster using declarative manifests managed through **Kustomize**.

The deployment follows cloud-native best practices including:

- Namespace isolation
- Rolling updates
- Horizontal Pod Autoscaler (HPA)
- Istio Service Mesh
- Network Policies
- Prometheus Monitoring
- Resource Requests & Limits
- Readiness/Liveness Probes
- ConfigMaps
- Service Accounts

The application is deployed automatically through the Jenkins CI/CD pipeline using Ansible.

---

# Deployment Architecture

```
GitHub

      │

      ▼

Jenkins Pipeline

      │

      ▼

Ansible

      │

      ▼

kubectl apply -k kubernetes/

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

# Kubernetes Cluster

The project runs on a three-node Kubernetes cluster.

| Node | Role |
|------|------|
| k8s-master | Control Plane |
| k8s-worker1 | Infrastructure Workloads |
| k8s-worker2 | Application Workloads |

Application pods are scheduled on the application node using node affinity.

---

# Directory Structure

```
kubernetes/

├── configmap.yaml
├── deployment.yaml
├── hpa.yaml
├── ingress.yaml
├── kustomization.yaml
├── namespace.yaml
├── networkpolicy.yaml
├── service.yaml
├── servicemonitor.yaml
└── serviceaccount.yaml
```

---

# Namespace

The application runs inside its own namespace.

```
abc-technologies
```

Benefits

- Isolation
- Security
- Resource management
- Easier monitoring

Create namespace

```bash
kubectl apply -f namespace.yaml
```

---

# ConfigMap

The ConfigMap stores application configuration.

Typical examples

- Environment
- URLs
- Feature flags
- Timezone

Deploy

```bash
kubectl apply -f configmap.yaml
```

---

# Service Account

A dedicated ServiceAccount is used by the application.

Benefits

- Least privilege
- RBAC ready
- Production security

Deploy

```bash
kubectl apply -f serviceaccount.yaml
```

---

# Deployment

The Deployment manages application Pods.

Features

- Rolling Updates
- Replica Management
- Self Healing
- Resource Limits
- Health Checks

Example

```
Replicas

↓

ReplicaSet

↓

Pods

↓

Containers
```

Deploy

```bash
kubectl apply -f deployment.yaml
```

---

# Rolling Updates

Deployment strategy

```
Old Pods

↓

New Pods Created

↓

Readiness Check

↓

Traffic Shift

↓

Old Pods Removed
```

Benefits

- Zero downtime
- Automatic rollback support
- Safe deployments

---

# Resource Requests

CPU

```
260m
```

Memory

```
552Mi
```

These values help the Kubernetes Scheduler determine where Pods can run.

---

# Resource Limits

CPU

```
3 CPU
```

Memory

```
2Gi
```

Limits prevent applications from consuming excessive resources.

---

# Health Probes

The deployment includes three health probes.

## Startup Probe

Checks whether the application has successfully started.

---

## Readiness Probe

Determines whether the application is ready to receive traffic.

If the readiness probe fails

```
Pod receives NO traffic.
```

---

## Liveness Probe

Checks whether the application is healthy.

If it fails

```
Kubernetes automatically restarts the container.
```

---

# Scheduling

Pods are scheduled using Node Affinity.

Application workloads are deployed to

```
k8s-worker2
```

Node labels

```
role=app

tier=application

workload=app
```

Infrastructure workloads remain on

```
k8s-worker1
```

---

# Service

The Service exposes the Pods inside the cluster.

Type

```
ClusterIP
```

Port

```
80
```

Target Port

```
8080
```

Verify

```bash
kubectl get svc \
-n abc-technologies
```

---

# Ingress

Ingress exposes the application externally.

Traffic Flow

```
Internet

↓

NGINX Ingress

↓

ClusterIP Service

↓

Pods
```

Benefits

- HTTP Routing
- Load Balancing
- TLS Ready
- Single Entry Point

---

# Horizontal Pod Autoscaler

The application scales automatically.

Example

```
Minimum Replicas

2

↓

Maximum Replicas

5
```

Metrics

- CPU Utilization
- Memory Utilization

Verify

```bash
kubectl get hpa \
-n abc-technologies
```

---

# Network Policy

The application is protected using Kubernetes Network Policies.

Allowed Ingress

- Same namespace Pods
- NGINX Ingress
- Istio
- Prometheus

Allowed Egress

- DNS
- HTTP
- HTTPS
- Kubernetes API
- Istio Control Plane
- Monitoring Namespace

Benefits

- Zero Trust Networking
- Namespace Isolation
- Reduced Attack Surface

Verify

```bash
kubectl get networkpolicy \
-n abc-technologies
```

---

# Istio Service Mesh

Each application Pod includes an Envoy sidecar.

```
Application

+

Istio Proxy
```

Benefits

- mTLS
- Traffic Routing
- Retries
- Circuit Breaking
- Telemetry
- Metrics

Verify

```bash
kubectl get pods \
-n abc-technologies
```

Expected

```
READY

2/2
```

Application Container

+

Istio Proxy

---

# Prometheus Monitoring

Prometheus discovers the application using a ServiceMonitor.

Monitoring Flow

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

↓

Metrics
```

Verify

```bash
kubectl get servicemonitor -A
```

---

# Kustomize

All manifests are managed using Kustomize.

Benefits

- Single deployment command
- Environment customization
- Resource management
- Label injection

Deploy

```bash
kubectl apply -k kubernetes/
```

Preview

```bash
kubectl kustomize kubernetes/
```

---

# Deployment Validation

Verify namespace

```bash
kubectl get ns
```

Verify deployment

```bash
kubectl get deployment \
-n abc-technologies
```

Verify ReplicaSet

```bash
kubectl get rs \
-n abc-technologies
```

Verify Pods

```bash
kubectl get pods \
-o wide \
-n abc-technologies
```

Verify Service

```bash
kubectl get svc \
-n abc-technologies
```

Verify Ingress

```bash
kubectl get ingress \
-n abc-technologies
```

Verify HPA

```bash
kubectl get hpa \
-n abc-technologies
```

Verify ConfigMap

```bash
kubectl get configmap \
-n abc-technologies
```

Verify ServiceAccount

```bash
kubectl get sa \
-n abc-technologies
```

Verify Network Policy

```bash
kubectl get networkpolicy \
-n abc-technologies
```

Verify ServiceMonitor

```bash
kubectl get servicemonitor \
-A
```

Verify rollout

```bash
kubectl rollout status deployment \
abc-technologies \
-n abc-technologies
```

Describe deployment

```bash
kubectl describe deployment \
abc-technologies \
-n abc-technologies
```

Describe pod

```bash
kubectl describe pod \
<pod-name> \
-n abc-technologies
```

Logs

```bash
kubectl logs \
<pod-name> \
-n abc-technologies
```

---

# Self-Healing

Kubernetes continuously monitors the application.

If

- Container crashes
- Pod fails
- Node fails

Kubernetes automatically

- Restarts containers
- Creates replacement Pods
- Reschedules Pods on healthy nodes

---

# Scalability

The platform supports horizontal scaling through HPA.

Example

```
2 Pods

↓

High CPU

↓

4 Pods

↓

Traffic Distributed

↓

CPU Normal

↓

Scale Back
```

---

# Security Features

The deployment includes

- Namespace Isolation
- Service Accounts
- RBAC Ready
- Network Policies
- Istio mTLS Ready
- Resource Limits
- Readiness Probes
- Liveness Probes
- Immutable Containers
- Declarative Infrastructure

---

# Benefits

This Kubernetes deployment provides

- High Availability
- Automatic Scaling
- Zero Downtime Deployments
- Self-Healing
- Secure Networking
- Enterprise Monitoring
- Service Mesh Integration
- GitOps Ready Architecture
- Production-grade Kubernetes Deployment

---

# Author

**Project:** ABC-Technologies

**Platform:** Kubernetes

**Maintainer:** Bharat Dasa