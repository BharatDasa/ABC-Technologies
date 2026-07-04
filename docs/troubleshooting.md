# Troubleshooting Guide

## Overview

This document provides common troubleshooting steps for the ABC-Technologies platform.

The project consists of:

- GitHub
- Jenkins
- Maven
- SonarQube
- Nexus
- Docker
- Kaniko
- Trivy
- Kubernetes
- Istio
- Prometheus
- Grafana
- Ansible

This guide helps diagnose problems during build, deployment, monitoring, and runtime.

---

# Troubleshooting Workflow

```
Problem

↓

Identify Component

↓

Collect Logs

↓

Check Configuration

↓

Verify Connectivity

↓

Apply Fix

↓

Redeploy

↓

Validate
```

---

# GitHub Issues

## Repository not updating

### Symptoms

- Jenkins builds old code
- Recent commits not available

### Verify

```bash
git status
```

```bash
git log
```

```bash
git remote -v
```

### Solution

```bash
git fetch --all
```

```bash
git pull origin master
```

---

# Jenkins Pipeline Failure

### Symptoms

- Pipeline stops
- Stage fails

### Check

```bash
kubectl get pods -n infra
```

Pipeline Agent

```bash
kubectl logs \
<POD_NAME> \
-n infra \
-c jnlp
```

Pipeline Console

```
Jenkins

↓

Build

↓

Console Output
```

---

# Jenkins Agent Not Starting

### Symptoms

```
Pending
```

or

```
ContainerCreating
```

### Verify

```bash
kubectl get pods -n infra
```

Describe

```bash
kubectl describe pod \
<POD_NAME> \
-n infra
```

Common causes

- Image pull failure
- Resource shortage
- Node unavailable

---

# Maven Build Failure

### Symptoms

```
BUILD FAILURE
```

### Verify

```bash
mvn clean package
```

Dependency tree

```bash
mvn dependency:tree
```

Force dependency download

```bash
mvn clean install -U
```

---

# Unit Tests Failing

Run

```bash
mvn test
```

Reports

```
target/surefire-reports
```

Common reasons

- Assertion failure
- NullPointerException
- Missing test data

---

# SonarQube Failure

Verify

```bash
curl http://<SONAR_URL>:9000
```

Check

- Sonar Token
- Quality Gate
- Scanner configuration

---

# Nexus Upload Failure

Verify

```bash
curl http://<NEXUS_IP>:8081
```

Check

- Credentials
- Repository URL
- Firewall
- Network

---

# Docker Image Build Failure

Verify Dockerfile

```bash
docker build .
```

Check

- Base image
- COPY paths
- Build context

---

# Kaniko Failure

Verify

```bash
kubectl logs \
<POD_NAME> \
-c kaniko \
-n infra
```

Common causes

- Registry authentication
- Invalid Dockerfile
- Incorrect destination

---

# Trivy Scan Failure

Verify

```bash
kubectl logs \
<POD_NAME> \
-c trivy \
-n infra
```

Check

- Network connectivity
- CVE database download
- Registry access

---

# Kubernetes Deployment Failure

Check

```bash
kubectl get deployment \
-n abc-technologies
```

Describe

```bash
kubectl describe deployment \
abc-technologies \
-n abc-technologies
```

---

# Pod Pending

Verify

```bash
kubectl get pods \
-o wide \
-n abc-technologies
```

Describe

```bash
kubectl describe pod \
<POD_NAME> \
-n abc-technologies
```

Common reasons

- Insufficient CPU
- Insufficient Memory
- Node Affinity mismatch
- PVC unavailable

Check events

```bash
kubectl get events \
-n abc-technologies \
--sort-by=.lastTimestamp
```

---

# CrashLoopBackOff

Logs

```bash
kubectl logs \
<POD_NAME> \
-n abc-technologies
```

Previous logs

```bash
kubectl logs \
<POD_NAME> \
--previous \
-n abc-technologies
```

---

# ImagePullBackOff

Describe

```bash
kubectl describe pod \
<POD_NAME> \
-n abc-technologies
```

Check

- Image name
- Registry
- Credentials
- Image tag

---

# Pods Not Ready

Verify

```bash
kubectl get pods \
-n abc-technologies
```

Describe

```bash
kubectl describe pod \
<POD_NAME>
```

Check

- Startup Probe
- Readiness Probe
- Liveness Probe

---

# Service Not Working

Verify

```bash
kubectl get svc \
-n abc-technologies
```

Describe

```bash
kubectl describe svc \
abc-technologies \
-n abc-technologies
```

Endpoints

```bash
kubectl get endpoints \
-n abc-technologies
```

---

# Ingress Issues

Verify

```bash
kubectl get ingress \
-n abc-technologies
```

Describe

```bash
kubectl describe ingress \
-n abc-technologies
```

Ingress Controller

```bash
kubectl get pods \
-n platform
```

---

# Namespace Missing

Verify

```bash
kubectl get ns
```

Create

```bash
kubectl create namespace abc-technologies
```

---

# ConfigMap Issues

Verify

```bash
kubectl get configmap \
-n abc-technologies
```

Describe

```bash
kubectl describe configmap
```

---

# Network Policy Problems

Check

```bash
kubectl get networkpolicy \
-n abc-technologies
```

Describe

```bash
kubectl describe networkpolicy \
-n abc-technologies
```

Temporarily delete

```bash
kubectl delete networkpolicy \
abc-technologies-network-policy \
-n abc-technologies
```

Reapply

```bash
kubectl apply -f networkpolicy.yaml
```

---

# Istio Sidecar Missing

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

Describe

```bash
kubectl describe pod \
<POD_NAME>
```

Check labels

```bash
kubectl get namespace \
abc-technologies \
--show-labels
```

---

# Istio Injection

Enable

```bash
kubectl label namespace \
abc-technologies \
istio-injection=enabled \
--overwrite
```

Restart

```bash
kubectl rollout restart deployment \
abc-technologies \
-n abc-technologies
```

---

# Prometheus Target Down

Check

```bash
kubectl get servicemonitor -A
```

Service

```bash
kubectl get svc \
-n abc-technologies
```

Endpoints

```bash
kubectl get endpoints \
-n abc-technologies
```

Target

```bash
kubectl get pod \
-o wide \
-n abc-technologies
```

Check metrics

```bash
kubectl exec -it \
prometheus-monitoring-kube-prometheus-prometheus-0 \
-n monitoring \
-c prometheus -- sh
```

Inside container

```bash
wget -qO- \
http://<POD_IP>:15090/stats/prometheus | head
```

---

# ServiceMonitor Missing

Verify

```bash
kubectl get servicemonitor -A
```

Apply

```bash
kubectl apply \
-f servicemonitor.yaml
```

---

# HPA Not Scaling

Verify

```bash
kubectl get hpa \
-n abc-technologies
```

Metrics

```bash
kubectl top pod \
-n abc-technologies
```

Metrics Server

```bash
kubectl get pods \
-n kube-system
```

---

# Node Problems

Nodes

```bash
kubectl get nodes -o wide
```

Describe

```bash
kubectl describe node \
k8s-worker2
```

---

# Disk Pressure

Check

```bash
df -h
```

Node

```bash
kubectl describe node
```

---

# Resource Usage

Nodes

```bash
kubectl top node
```

Pods

```bash
kubectl top pod \
-A
```

---

# Events

Recent events

```bash
kubectl get events \
-A \
--sort-by=.lastTimestamp
```

---

# Rollout Status

```bash
kubectl rollout status deployment \
abc-technologies \
-n abc-technologies
```

History

```bash
kubectl rollout history deployment \
abc-technologies \
-n abc-technologies
```

Rollback

```bash
kubectl rollout undo deployment \
abc-technologies \
-n abc-technologies
```

---

# Restart Deployment

```bash
kubectl rollout restart deployment \
abc-technologies \
-n abc-technologies
```

---

# Delete Pods

```bash
kubectl delete pod \
-l app=abc-technologies \
-n abc-technologies
```

---

# Validate Deployment

Pods

```bash
kubectl get pods \
-o wide \
-n abc-technologies
```

Service

```bash
kubectl get svc \
-n abc-technologies
```

Ingress

```bash
kubectl get ingress \
-n abc-technologies
```

Deployment

```bash
kubectl get deployment \
-n abc-technologies
```

HPA

```bash
kubectl get hpa \
-n abc-technologies
```

ServiceMonitor

```bash
kubectl get servicemonitor -A
```

NetworkPolicy

```bash
kubectl get networkpolicy \
-n abc-technologies
```

---

# Useful Commands

Cluster

```bash
kubectl cluster-info
```

Namespaces

```bash
kubectl get ns
```

Nodes

```bash
kubectl get nodes -o wide
```

Pods

```bash
kubectl get pods -A
```

Services

```bash
kubectl get svc -A
```

Ingress

```bash
kubectl get ingress -A
```

Deployments

```bash
kubectl get deployment -A
```

ReplicaSets

```bash
kubectl get rs -A
```

Events

```bash
kubectl get events -A --sort-by=.lastTimestamp
```

Logs

```bash
kubectl logs <pod> -n <namespace>
```

Describe

```bash
kubectl describe pod <pod>
```

---

# Common Issues Summary

| Issue | Typical Cause | Solution |
|--------|---------------|----------|
| Pipeline Failed | Jenkins stage error | Review console logs |
| Pod Pending | Insufficient resources | Check scheduler events |
| CrashLoopBackOff | Application error | Inspect pod logs |
| ImagePullBackOff | Registry issue | Verify image and credentials |
| Service Unreachable | Selector mismatch | Check Service and Endpoints |
| Ingress Not Working | Controller/configuration | Verify Ingress resources |
| Prometheus Target Down | ServiceMonitor, NetworkPolicy, metrics endpoint | Validate scrape path and connectivity |
| HPA Not Scaling | Metrics unavailable | Verify Metrics Server |
| Istio Sidecar Missing | Injection disabled | Enable namespace injection |
| Namespace Missing | Deployment order | Create namespace |

---

# Best Practices

- Review Jenkins console output first.
- Use `kubectl describe` before making changes.
- Inspect pod logs before restarting workloads.
- Check Kubernetes events for scheduling or networking problems.
- Validate Service selectors and Endpoints.
- Verify Prometheus targets after each deployment.
- Roll back failed deployments instead of patching live resources.
- Keep Kubernetes manifests under version control.
- Test changes in a non-production namespace before promoting them.

---

# Author

**Project:** ABC-Technologies

**Maintainer:** Bharat Dasa