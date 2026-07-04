# Jenkins Pipeline

## Overview

The ABC-Technologies project uses a fully automated Jenkins Pipeline to implement Continuous Integration and Continuous Deployment (CI/CD).

Every code commit triggers an automated workflow that:

- Checks out the latest source code
- Builds the application
- Executes unit tests
- Generates code coverage reports
- Performs static code analysis
- Publishes artifacts to Nexus
- Builds a Docker image
- Scans the image for vulnerabilities
- Pushes the image to the container registry
- Deploys the application to Kubernetes
- Performs post-deployment validation

This pipeline follows modern DevSecOps practices and is designed for production-ready deployments.

---

# Pipeline Architecture

```
Developer

      │

      ▼

GitHub Repository

      │

      ▼

Webhook

      │

      ▼

Jenkins

      │

      ▼

Dynamic Kubernetes Agent

      │

      ▼

Git Checkout

      │

      ▼

Maven Build

      │

      ▼

Unit Testing

      │

      ▼

JaCoCo Coverage

      │

      ▼

SonarQube Analysis

      │

      ▼

Quality Gate

      │

      ▼

Publish WAR to Nexus

      │

      ▼

Docker Build (Kaniko)

      │

      ▼

Trivy Security Scan

      │

      ▼

Push Image

      │

      ▼

Ansible Deployment

      │

      ▼

kubectl apply -k

      │

      ▼

Deployment Verification

      │

      ▼

Production
```

---

# Jenkins Infrastructure

The Jenkins Controller runs inside Kubernetes.

Each pipeline execution launches a temporary Kubernetes Pod containing multiple specialized containers.

```
Jenkins Controller

        │

        ▼

Kubernetes Plugin

        │

        ▼

Dynamic Agent Pod

    ├── jnlp
    ├── maven
    ├── kaniko
    ├── trivy
    └── ansible
```

The build pod is automatically destroyed after the pipeline completes.

---

# Build Containers

## JNLP Container

Purpose

- Connects Jenkins Controller with the Kubernetes Agent.

Responsibilities

- Pipeline communication
- Workspace management
- Agent lifecycle

---

## Maven Container

Purpose

Build the Java application.

Responsibilities

- Compile source code
- Execute unit tests
- Generate JaCoCo reports
- Perform SonarQube analysis
- Publish artifacts to Nexus

Example

```bash
mvn clean deploy
```

---

## Kaniko Container

Purpose

Build Docker images without requiring Docker daemon.

Responsibilities

- Build OCI image
- Push image to registry

Example

```bash
executor \
--context=. \
--dockerfile=Dockerfile \
--destination=registry/abc-technologies:latest
```

---

## Trivy Container

Purpose

Container image vulnerability scanning.

Responsibilities

- Detect CVEs
- Generate reports
- Fail build on critical vulnerabilities (optional)

Example

```bash
trivy image registry/abc-technologies:latest
```

---

## Ansible Container

Purpose

Deploy Kubernetes resources.

Responsibilities

- Execute Ansible Playbooks
- Apply Kubernetes manifests
- Validate deployment

---

# Pipeline Stages

## Stage 1

### Checkout Source

Downloads source code from GitHub.

Example

```bash
git clone
```

---

## Stage 2

### Build

Compiles the project.

Command

```bash
mvn clean package
```

Outputs

- WAR file

---

## Stage 3

### Unit Testing

Runs automated JUnit tests.

Command

```bash
mvn test
```

Outputs

```
Surefire Reports
```

---

## Stage 4

### Code Coverage

Generates JaCoCo report.

Command

```bash
mvn verify
```

Outputs

```
target/site/jacoco
```

---

## Stage 5

### SonarQube Analysis

Runs static code analysis.

Command

```bash
mvn sonar:sonar
```

Checks

- Bugs
- Vulnerabilities
- Code Smells
- Duplicated Code
- Coverage

---

## Stage 6

### Quality Gate

Waits for SonarQube Quality Gate.

If Quality Gate fails

```
Pipeline Stops
```

If passed

```
Pipeline Continues
```

---

## Stage 7

### Publish Artifact

Uploads WAR to Nexus.

Command

```bash
mvn deploy
```

Repository

```
Maven Releases

or

Maven Snapshots
```

---

## Stage 8

### Docker Image Build

Kaniko builds the image.

Dockerfile

```
docker/Dockerfile
```

Output

```
abc-technologies:latest
```

---

## Stage 9

### Security Scan

Trivy scans image.

Checks

- Critical CVEs
- High CVEs
- OS Packages
- Java Libraries

---

## Stage 10

### Push Image

Uploads image to registry.

Example

```
registry/abc-technologies:1.0.0
```

---

## Stage 11

### Kubernetes Deployment

Ansible executes

```bash
kubectl apply -k kubernetes/
```

Resources deployed

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

## Stage 12

### Verification

Pipeline verifies

Deployment

```bash
kubectl rollout status deployment
```

Pods

```bash
kubectl get pods
```

Services

```bash
kubectl get svc
```

Ingress

```bash
kubectl get ingress
```

---

## Stage 13

### Post Deployment Validation

Checks

- Pods Running
- Containers Ready
- Image Updated
- Service Reachable
- Prometheus Scraping
- Istio Sidecar Injected
- HPA Active

---

# Jenkins Workspace

Typical workspace structure

```
workspace/

└── ABC-Technologies
      ├── ansible/
      ├── docker/
      ├── docs/
      ├── jenkins/
      ├── kubernetes/
      ├── scripts/
      ├── src/
      ├── pom.xml
      └── Dockerfile
```

---

# Generated Artifacts

Pipeline generates

```
WAR File

Docker Image

JaCoCo Report

Surefire Report

SonarQube Report

Trivy Report
```

---

# Deployment Flow

```
GitHub

↓

Checkout

↓

Build

↓

Test

↓

Coverage

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

Ansible

↓

Kubernetes

↓

Verification
```

---

# Failure Handling

Pipeline automatically stops if

- Git checkout fails
- Maven build fails
- Unit tests fail
- SonarQube Quality Gate fails
- Nexus upload fails
- Docker image build fails
- Trivy scan fails (configurable)
- Kubernetes deployment fails
- Rollout timeout occurs

---

# Kubernetes Validation Commands

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
kubectl get servicemonitor \
-A
```

Verify rollout

```bash
kubectl rollout status deployment \
abc-technologies \
-n abc-technologies
```

---

# Security Features

The pipeline includes

- Immutable Docker Images
- Kubernetes Secrets
- SonarQube Static Analysis
- Trivy Vulnerability Scanning
- Network Policies
- Istio Service Mesh
- Readiness Probes
- Liveness Probes
- Startup Probes
- Least Privilege Service Accounts

---

# Monitoring

After deployment the application is monitored using

- Prometheus
- Grafana
- Istio Metrics
- Kubernetes Metrics Server
- Horizontal Pod Autoscaler
- Loki Logs
- Tempo Traces
- OpenTelemetry Collector

---

# Benefits

This pipeline provides

- Fully Automated CI/CD
- Dynamic Jenkins Agents
- Immutable Deployments
- Secure Image Scanning
- Automated Rollbacks
- Production-grade Kubernetes Deployment
- Observability
- Scalability
- Enterprise DevSecOps Workflow

---

# Author

**Project:** ABC-Technologies

**Pipeline:** Enterprise Kubernetes CI/CD

**Maintainer:** Bharat Dasa