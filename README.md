# indico-tf

# Architecture
![arc](https://raw.githubusercontent.com/mfisya/indico-tf/refs/heads/master/doc/arch.png)

## Overview

Key Components and Flow:
- Client Interaction (Top Left)
    - Mobile App & Web interact with the system through the internet.
    - Route53 (DNS) directs traffic to web.indico.com or api.indico.com
    - Public access protected with three layer, first firewall second WAF and third is auth from api gateway inside EKS
- VPC Hub & VPN Security
    - Teleport in the Public Subnet provides secure access for DevOps and developers.
    - Teleport give End-to-End Encryption , MFA, and Zero Trust Networking, etc
    - Developers access teleport.indico.com via the internet or can be enhance via another VPN like OpenVPN layer.
- VPC Production & Development
    - VPC Development: Hosts EC2 instances and Amazon EKS (Elastic Kubernetes Service).
    - VPC Production: Private subnets contain EC2 & EKS clusters, and traffic is routed through NAT Gateways for external access.
- Third-Party Integrations (Bottom Center)
    - VPN Site-to-Site and Direct Connect establish connections with Partner Payment Gateway.
    - Transit Gateway manages multiple route tables for partners.
    - Using private nat to access outside VPC
- Load Balancing & Secrets Management (Bottom)
    - NLB (Network Load Balancer) handles incoming traffic to EKS Nodes. (NLB auto created by kubernetes services)
    - EKS Nodes host microservices (e.g., foo-service, bar-service), which interact with Vault for secret management with external operator pattern.

# CICD Diagram
![arc](https://raw.githubusercontent.com/mfisya/indico-tf/refs/heads/master/doc/cicd.png)

## CI/CD Pipeline Architecture

## 1. Overview of the CI/CD Pipeline
This pipeline automates the **build, test, and deployment** process with the following key components:

- **Bitbucket Pipelines**: Automates CI/CD workflows.
- **Amazon ECR (Elastic Container Registry)**: Stores Docker images and Helm charts.
- **Amazon EKS (Elastic Kubernetes Service)**: Serves as the deployment target for applications.

---

## 2. Bitbucket Pipelines Integration
The **`bitbucket-pipelines.yml`** file is responsible for managing the CI/CD process. It includes:

- **AWS CLI**: Executes AWS operations.
- **Docker Build & Push**: Builds and pushes container images to **Amazon ECR**.
- **Helm Deployment**: Upgrades and installs Helm charts on **Amazon EKS**.
- **Zero Downtime Deployment**: Uses **Kubernetes liveness & readiness probes** to ensure smooth rollouts.

---

## 3. Infrastructure Setup
The architecture consists of:

- **Bitbucket Cloud**: Triggers the CI/CD pipeline.
- **EC2 Auto Scaling Group** with **Bitbucket Runners**:
  - `bitbucket-runner-private-01`
  - `bitbucket-runner-private-02`
  - `bitbucket-runner-private-N`
- **Public Subnet inside a VPC**: Houses the Bitbucket runners.
- **VPC Peering Connection**: Connects the **public subnet (CI/CD Runners)** with **VPC Production (Amazon EKS)**.

---

## 4. Security & Secure Coding Practices
Security is integrated into the pipeline using **SonarQube**, ensuring code quality and vulnerability checks:

### **SonarQube Security Scans**
- **Static Code Analysis**
- **Unit Test Coverage** (Minimum **80%** required)
- **Vulnerability & OWASP Security Scan**

**Example SonarQube Command:**
```sh
mvn clean install -U sonar:sonar -Dsonar.projectKey=$SONAR_PROJECT_KEY -Dsonar.host.url=$SONAR_HOST_URL
```

# Terraform Structure
The Terraform structure for this project follows the recommended best practices. Here is an overview of the directory structure:

```
├── main.tf
├── variables.tf
├── outputs.tf
├── modules/
│   ├── module1/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── module2/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
├── environments/
│   ├── dev/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── prod/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
├── infrastructures/
├── data/
│   ├── data_source1.tf
│   ├── data_source2.tf
├── providers.tf
├── backend.tf
```

This structure separates the main configuration files (`main.tf`, `variables.tf`, `outputs.tf`) from the modules and environments. The `modules` directory contains reusable modules that can be used across different environments. The `environments` directory contains environment-specific configurations. The `data` directory contains data sources used in the Terraform configuration. The `providers.tf` file specifies the providers used in the project, and the `backend.tf` file defines the backend configuration for remote state storage. The `infrastructures` directory can be used to store any additional infrastructure-related files or scripts.


Feel free to customize this structure based on your project's specific needs.
