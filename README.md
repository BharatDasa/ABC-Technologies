# ABC-Technologies

![Java](https://img.shields.io/badge/Java-17-blue)
![Maven](https://img.shields.io/badge/Maven-3.9-red)
![Docker](https://img.shields.io/badge/Docker-Container-blue)
![Kubernetes](https://img.shields.io/badge/Kubernetes-1.29-blue)
![Jenkins](https://img.shields.io/badge/Jenkins-CI/CD-red)
![Ansible](https://img.shields.io/badge/Ansible-Automation-red)
![Kaniko](https://img.shields.io/badge/Kaniko-Container%20Build-green)
![Trivy](https://img.shields.io/badge/Trivy-Security-orange)
![Prometheus](https://img.shields.io/badge/Prometheus-Monitoring-orange)
![Grafana](https://img.shields.io/badge/Grafana-Dashboard-yellow)
![NGINX](https://img.shields.io/badge/NGINX-Ingress-green)
![Istio](https://img.shields.io/badge/Istio-Service%20Mesh-blue)
![License](https://img.shields.io/badge/License-MIT-green)

---

# Enterprise DevSecOps Platform for Java Applications

ABC-Technologies is a production-style DevSecOps platform demonstrating a complete Continuous Integration and Continuous Delivery (CI/CD) pipeline for Java web applications running on Kubernetes.

The project integrates modern DevOps tools including Jenkins, Maven, Nexus Repository, Kaniko, Trivy, Ansible, Kubernetes, Istio, Prometheus, Grafana, and Horizontal Pod Autoscaler (HPA) to provide a secure, automated, and scalable deployment workflow.

The objective of this repository is to simulate an enterprise-grade software delivery platform using Infrastructure as Code (IaC), containerization, security scanning, configuration management, and Kubernetes-native deployment practices.

---

# Project Objectives

- Build Java applications using Maven.
- Store versioned artifacts in Nexus Repository.
- Build container images using Kaniko.
- Push Docker images to a private Nexus Registry.
- Perform automated vulnerability scanning using Trivy.
- Automate deployment using Ansible.
- Deploy applications to Kubernetes using Kustomize.
- Expose applications through NGINX Ingress.
- Scale workloads automatically using HPA.
- Monitor applications using Prometheus and Grafana.
- Demonstrate rollback and health verification.
- Follow production-ready DevSecOps best practices.

---

## Platform Infrastructure

---

# 🏗 Enterprise Platform Infrastructure

This application is built on top of a reusable **Enterprise Platform Engineering** foundation that provides the complete DevSecOps, GitOps, Kubernetes, Observability, and Platform Engineering ecosystem used across all of my projects.

The platform repository includes enterprise-grade infrastructure such as:

- Jenkins Dynamic Kubernetes Agents
- GitHub Actions
- GitOps with ArgoCD
- Kubernetes Cluster Configuration
- Helm Charts
- Docker & Kaniko Image Builds
- Apache Tomcat Deployment
- Nexus Artifact Repository
- Ansible Automation
- Trivy DevSecOps Security Pipeline
- Storage setup(NFS)
- Database (PSQL, MONGODB)
- Kafka
- Airflow
- Keda
- HPA
- Prometheus Monitoring
- Grafana Dashboards
- Loki Log Aggregation
- Promtail Log Collection
- Tempo Distributed Tracing
- OpenTelemetry
- AlertManager
- Slack Notifications
- Horizontal Pod Autoscaler (HPA)
- Istio Service Mesh
- Multi-Environment Deployments (Development, Staging, Production)
- Enterprise CI/CD Pipelines
- Infrastructure Automation
- Platform Documentation

> **Repository:** Platform-Engineering-Devops-setup *(Private Repository)*

🔒 **Access Notice**

The Platform Engineering repository is currently **private** because it contains reusable enterprise platform components, infrastructure automation, deployment templates, and internal platform configurations shared across multiple projects.

If you are a **recruiter, hiring manager, interviewer, or engineering professional** interested in reviewing the complete Platform Engineering implementation, please contact me to request access.

📧 **Email:** **dasabharat90@gmail.com**

Access requests are reviewed and granted upon request.

---


# High-Level Architecture

```text
                    GitHub Repository
                            │
                            ▼
                       Jenkins Pipeline
                            │
        ┌───────────────────┼────────────────────┐
        ▼                   ▼                    ▼
     Maven              Nexus Repository      Kaniko
        │                   │                    │
        └──────────────► Docker Image ◄──────────┘
                            │
                            ▼
                     Trivy Security Scan
                            │
                            ▼
                    Ansible Automation
                            │
                            ▼
                 Kubernetes Cluster (K8s)
                            │
        ┌──────────────┬──────────────┬──────────────┐
        ▼              ▼              ▼              ▼
   Deployment       Service        Ingress         HPA
                            │
                            ▼
                     NGINX Ingress
                            │
                            ▼
                 ABC-Technologies Application
                            │
                            ▼
                Prometheus + Grafana Monitoring
```

---

# Key Features

- Enterprise CI/CD Pipeline
- Dynamic Jenkins Kubernetes Agents
- Maven Build Automation
- Nexus Artifact Repository
- Private Docker Registry
- Kaniko Image Build
- Trivy Container Security Scanning
- Automated Infrastructure Validation
- Kubernetes Native Deployment
- Rolling Updates
- Automatic Rollback
- Health Verification
- Horizontal Pod Autoscaling (HPA)
- Service Monitoring
- NGINX Ingress
- Istio Service Mesh Integration
- Infrastructure as Code (IaC)
- Configuration Management with Ansible
- Production-ready Repository Structure

---

# Technology Stack

| Category | Technology |
|-----------|------------|
| Programming Language | Java 17 |
| Build Tool | Maven |
| CI/CD | Jenkins |
| Artifact Repository | Nexus Repository |
| Container Runtime | Docker |
| Image Builder | Kaniko |
| Security Scanner | Trivy |
| Configuration Management | Ansible |
| Container Orchestration | Kubernetes |
| Service Mesh | Istio |
| Ingress Controller | NGINX Ingress |
| Monitoring | Prometheus |
| Visualization | Grafana |
| Autoscaling | Kubernetes HPA |
| Version Control | Git & GitHub |

---

# Repository Structure

```text
ABC-Technologies/

├── Jenkinsfile
├── Dockerfile
├── README.md
├── pom.xml

├── src/

├── ansible/

├── kubernetes/

├── scripts/

├── docs/

└── screenshots/
```

---

# CI/CD Workflow

```text
Developer
     │
     ▼
GitHub
     │
     ▼
Jenkins
     │
     ▼
Maven Build
     │
     ▼
Nexus Repository
     │
     ▼
Kaniko Build
     │
     ▼
Private Docker Registry
     │
     ▼
Trivy Security Scan
     │
     ▼
Ansible Deployment
     │
     ▼
Kubernetes
     │
     ▼
Health Check
     │
     ▼
Prometheus Verification
     │
     ▼
Production
```

---

## Repository Highlights

- Complete Enterprise DevSecOps Workflow
- Infrastructure as Code
- Secure Software Supply Chain
- Automated Deployment Pipeline
- Kubernetes Native Architecture
- Production-inspired Project Structure
- End-to-End Observability
- Enterprise Security Practices

---

# Infrastructure Overview

The project is designed to run on a self-managed Kubernetes cluster with enterprise-grade tooling already installed.

## Cluster Components

| Component | Status |
|------------|--------|
| Kubernetes | ✅ |
| Jenkins | ✅ |
| Nexus Repository | ✅ |
| Kaniko | ✅ |
| Maven | ✅ |
| Docker Registry | ✅ |
| Ansible | ✅ |
| NGINX Ingress | ✅ |
| MetalLB | ✅ |
| Istio Service Mesh | ✅ |
| Prometheus | ✅ |
| Grafana | ✅ |
| Loki | ✅ |
| Tempo | ✅ |
| Horizontal Pod Autoscaler | ✅ |
| Metrics Server | ✅ |

---

# Kubernetes Cluster

The project is deployed on a three-node Kubernetes cluster.

| Node | Role |
|------|------|
| k8s-master | Control Plane |
| k8s-worker1 | Infrastructure Services |
| k8s-worker2 | Application Workloads |

---

# Infrastructure Services

The platform already contains the following enterprise services.

| Namespace | Service |
|-----------|----------|
| jenkins | Jenkins Controller |
| nexus | Nexus Repository |
| monitoring | Prometheus |
| monitoring | Grafana |
| monitoring | Loki |
| monitoring | Tempo |
| monitoring | AlertManager |
| platform | NGINX Ingress |
| platform | MetalLB |
| platform | Cert Manager |
| istio-system | Istio |

---

# Prerequisites

Before running this project, ensure the following components are installed.

- Java 17
- Maven 3.9+
- Docker
- Kubernetes 1.29+
- kubectl
- Jenkins
- Nexus Repository
- Kaniko
- Trivy
- Ansible
- Git
- GitHub SSH Key

---

# Jenkins Requirements

The Jenkins Kubernetes Cloud must already be configured.

Required containers inside the dynamic agent:

- jnlp
- maven
- kaniko
- ansible
- trivy

Required Credentials:

| Credential | Purpose |
|------------|----------|
| github-ssh | Clone GitHub Repository |
| ansible-ssh-key | SSH Authentication |

---

# Clone Repository

```bash
git clone git@github.com:BharatDasa/ABC-Technologies.git

cd ABC-Technologies
```

---

# Repository Layout

```text
ABC-Technologies/

├── Jenkinsfile
├── Dockerfile
├── pom.xml

├── src/

├── ansible/
│
├── kubernetes/
│
├── scripts/
│
├── docs/
│
└── screenshots/
```

---

# Ansible Structure

```text
ansible/

├── ansible.cfg

├── inventory.ini

├── group_vars/

├── host_vars/

├── playbooks/

│     auto-fix.yml

│     precheck.yml

│     deploy.yml

│     healthcheck.yml

│     rollback.yml

│     cleanup.yml
```

---

# Kubernetes Structure

```text
kubernetes/

namespace.yaml

configmap.yaml

serviceaccount.yaml

networkpolicy.yaml

deployment.yaml

service.yaml

ingress.yaml

servicemonitor.yaml

hpa.yaml

kustomization.yaml
```

---

# Deployment Architecture

```text
GitHub

↓

Jenkins

↓

Dynamic Kubernetes Agent

↓

Maven Build

↓

Nexus Repository

↓

Kaniko

↓

Docker Registry

↓

Trivy

↓

Ansible

↓

Kubernetes

↓

NGINX Ingress

↓

Application

↓

Prometheus

↓

Grafana
```

---

# Running Locally

Build the project

```bash
mvn clean package
```

Build Docker image

```bash
docker build -t abc-technologies .
```

Run locally

```bash
docker run -p 8080:8080 abc-technologies
```

Open

```
http://localhost:8080
```

---

# Running via Jenkins

Simply trigger

```
Build Now
```

The pipeline automatically performs

- Clone
- Build
- Nexus Upload
- Docker Build
- Security Scan
- Kubernetes Deployment
- Health Verification
- Cleanup

No manual deployment is required.

---

# Project Components

| Directory | Description |
|------------|-------------|
| src | Java Application |
| ansible | Deployment Automation |
| kubernetes | Kubernetes Manifests |
| scripts | Helper Scripts |
| docs | Documentation |
| screenshots | GitHub Images |

---

# Deployment Time

Approximate pipeline duration

| Stage | Time |
|--------|------|
| Clone | 15 sec |
| Maven Build | 1–2 min |
| Docker Build | 2 min |
| Trivy | 1–3 min |
| Deployment | 1 min |
| Health Check | 30 sec |

Average total execution:

**5–8 minutes**

---

# Jenkins CI/CD Pipeline

The Jenkins pipeline is fully automated and follows modern DevSecOps practices.

The pipeline runs on **dynamic Kubernetes agents**, meaning build environments are created on demand and automatically destroyed after execution.

No static Jenkins agents are required.

---

# Pipeline Stages

## 1. Initialize Version

Generate a unique application version.

Example

```
1.0.25-1748345938495
```

This version is used for

- Maven Artifact
- Docker Image
- Kubernetes Deployment

---

## 2. Clone Repository

Clone the latest source code from GitHub using SSH credentials.

```
GitHub

↓

Jenkins Workspace
```

---

## 3. Maven Build

Compile the Java application.

Execute

```bash
mvn clean deploy
```

This stage performs

- Compile
- Unit Test
- Package
- Upload WAR to Nexus

Output

```
abc-technologies.war
```

---

## 4. Docker Image Build

Kaniko builds the container image.

Unlike Docker-in-Docker,

Kaniko builds images directly inside Kubernetes.

```
Source Code

↓

Kaniko

↓

Docker Image

↓

Nexus Registry
```

Example

```
192.168.56.11:8082/abc-technologies:v25
```

---

## 5. Automatic Infrastructure Fix

Before deployment,

Ansible performs automatic validation.

Tasks include

- Verify Namespace
- Verify Kubernetes API
- Verify kubectl
- Verify Ingress Controller
- Verify Metrics Server
- Verify Prometheus
- Verify ServiceMonitor

Any missing prerequisites are corrected automatically.

---

## 6. Precheck Validation

Ansible validates

- Kubernetes Cluster
- Namespace
- Worker Nodes
- Storage
- Network
- Available Resources

Deployment continues only if validation succeeds.

---

## 7. Security Scan

Container images are scanned using Trivy.

Checks include

- Critical Vulnerabilities
- High Vulnerabilities
- Package Issues
- Operating System Packages
- Java Dependencies

If critical vulnerabilities exist,

the pipeline stops immediately.

---

## 8. HTML Security Report

Trivy generates an HTML report.

The report is published directly inside Jenkins.

Example

```
Jenkins

↓

Build

↓

Trivy Security Report
```

---

## 9. Kubernetes Deployment

Deployment is performed using

Ansible.

Ansible automatically

- Updates Deployment Image
- Executes Kustomize
- Applies Kubernetes Resources
- Waits for Rollout Completion

```
Ansible

↓

kubectl apply -k kubernetes/

↓

Deployment

↓

Pods
```

---

## 10. Health Verification

The deployment is validated.

Checks include

- Deployment
- ReplicaSet
- Pods
- Service
- Ingress
- HPA
- ServiceMonitor

Application URL

```
https://abc.192.168.56.100.nip.io
```

---

## 11. Monitoring Verification

Prometheus API is queried.

If Prometheus is unavailable,

deployment fails.

---

## 12. Cleanup

Temporary deployment files are removed.

Build workspace is cleaned.

Application remains deployed.

---

## 13. Rollback

If any deployment validation fails,

Ansible automatically executes

```
kubectl rollout undo
```

The previous application version becomes active.

---

# Complete Pipeline Flow

```text
Developer

↓

GitHub

↓

Jenkins

↓

Dynamic Kubernetes Agent

↓

Clone Repository

↓

Maven Build

↓

Nexus Repository

↓

Kaniko

↓

Docker Registry

↓

Trivy Scan

↓

Ansible Auto Fix

↓

Precheck

↓

Deploy

↓

Kubernetes

↓

Health Check

↓

Prometheus Verification

↓

Cleanup

↓

SUCCESS
```

If deployment fails

```text
Deployment Failure

↓

Rollback

↓

Previous Version Restored

↓

Pipeline Failed
```

---

# Security Features

The project follows multiple security best practices.

## Image Scanning

- Trivy
- Critical Vulnerability Detection
- HTML Reports

---

## Kubernetes

- ServiceAccount
- NetworkPolicy
- Resource Limits
- Health Probes

---

## Infrastructure

- SSH Key Authentication
- Private Docker Registry
- GitHub SSH Access

---

## CI/CD

- Dynamic Jenkins Agents
- Immutable Docker Images
- Automated Rollback
- Health Verification

---

# DevSecOps Workflow

```text
Development

↓

Build

↓

Artifact

↓

Container

↓

Security

↓

Automation

↓

Deployment

↓

Monitoring

↓

Production
```

---

# Enterprise Practices

This repository demonstrates

- Continuous Integration
- Continuous Delivery
- Infrastructure as Code
- Configuration Management
- Container Security
- Kubernetes Deployment
- Automated Rollback
- Observability
- Production Automation


# Screenshots

The following screenshots demonstrate the complete DevSecOps workflow.

---

## Repository

```
screenshots/

01-github-repository.png

02-project-structure.png

03-jenkins-dashboard.png

04-jenkins-build.png

05-dynamic-agent.png

06-maven-build.png

07-nexus-artifacts.png

08-kaniko-build.png

09-docker-image.png

10-trivy-report.png

11-kubernetes-pods.png

12-kubernetes-services.png

13-kubernetes-ingress.png

14-hpa.png

15-servicemonitor.png

16-prometheus-targets.png

17-grafana-dashboard.png

18-application-homepage.png

19-rollback.png

20-success-pipeline.png
```

---

# Expected Kubernetes Resources

After deployment

```
kubectl get all -n abc-technologies
```

Expected

```
Deployment

ReplicaSet

Pods

Service

Ingress

HorizontalPodAutoscaler
```

---

# Expected Monitoring Resources

```
kubectl get servicemonitor -A
```

```
abc-technologies
```

---

# Expected Application URL

```
https://abc.192.168.56.100.nip.io
```

---

# Troubleshooting

## Pods are not starting

```
kubectl get pods -n abc-technologies
```

```
kubectl describe pod <pod-name>
```

```
kubectl logs <pod-name>
```

---

## Deployment Failed

```
kubectl rollout status deployment/abc-technologies \
-n abc-technologies
```

---

## Rollback

```
kubectl rollout undo deployment/abc-technologies \
-n abc-technologies
```

---

## Ingress

```
kubectl get ingress -n abc-technologies
```

---

## Service

```
kubectl get svc -n abc-technologies
```

---

## HPA

```
kubectl get hpa -n abc-technologies
```

---

## ServiceMonitor

```
kubectl get servicemonitor -n monitoring
```

---

## Prometheus

```
kubectl get pods -n monitoring
```

---

## Jenkins

```
kubectl get pods -n jenkins
```

---

## Nexus

```
kubectl get pods -n nexus
```

---

# Project Highlights

This repository demonstrates

- Enterprise CI/CD Pipeline
- Jenkins Dynamic Kubernetes Agents
- Maven Build Automation
- Nexus Repository Integration
- Private Docker Registry
- Kaniko Image Build
- Trivy Security Scanning
- Ansible Configuration Management
- Kubernetes Native Deployment
- Kustomize
- Horizontal Pod Autoscaler
- NGINX Ingress
- Istio Service Mesh
- Prometheus Monitoring
- Grafana Dashboards
- Health Verification
- Automatic Rollback
- Infrastructure as Code
- Production-inspired Repository Structure

---

# Future Improvements

Potential future enhancements include

- Argo CD GitOps Deployment

- Helm Charts

- Kubernetes Secrets Management

- HashiCorp Vault Integration

- OpenTelemetry Distributed Tracing

- SonarQube Code Quality Analysis

- OWASP Dependency Check

- Kubernetes Admission Controller

- Progressive Delivery

- Blue-Green Deployment

- Canary Deployment

- Multi-Cluster Deployment

- Multi-Environment Support

---

# Documentation

Additional documentation is available in

```
docs/

architecture.md

deployment.md

jenkins-pipeline.md

kubernetes.md

troubleshooting.md

project-flow.md
```

---

# License

This project is licensed under the MIT License.

See

```
LICENSE
```

for additional information.

---

# Author

**Bharat Dasa**

DevOps Engineer | Kubernetes | Cloud | Automation | CI/CD | Infrastructure as Code

GitHub

```
https://github.com/BharatDasa
```

---

# Support

If you found this repository useful,

please consider

⭐ Starring the repository

🍴 Forking the repository

🛠 Contributing improvements

---

# Thank You

Thank you for visiting the ABC-Technologies repository.

This project was created to demonstrate modern DevSecOps practices using Kubernetes, Jenkins, Docker, Kaniko, Ansible, Nexus Repository, Prometheus, Grafana, Istio, and cloud-native deployment principles.

Happy Learning!
