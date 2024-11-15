# (OUTDATED) IoT Cloud Architecture Monorepo

## This README is outdated and will be updated soon. Thanks for your understanding

This repository contains a monorepo for an IoT application built with Go, along with the infrastructure and deployment pipelines for a complete cloud-native architecture. The project integrates MQTT for messaging, RabbitMQ for message brokering, AWS for cloud resources, and Kubernetes for orchestration.

## Table of Contents

1. [Overview](#overview)
2. [Project Structure](#project-structure)
3. [Getting Started](#getting-started)
4. [Application](#application)
5. [Infrastructure](#infrastructure)
6. [CI/CD Pipelines](#cicd-pipelines)
7. [Deployment](#deployment)
8. [Contributing](#contributing)
9. [License](#license)

## Overview

This monorepo provides the following:

- An **IoT application** written in Go that communicates using MQTT.
- **Infrastructure as Code (IaC)** for AWS resources using Terraform.
- **Kubernetes manifests** for deploying services on a K8s cluster.
- A **CI/CD pipeline** for automated builds and deployments.

## Project Structure

The repository is organized as follows:

```plaintext
.
├── .github
│   └── workflows
│       ├── ci-cd-pipeline.yaml          # CI/CD pipeline configuration
│       ├── rabbitmq-deploy.yaml         # RabbitMQ deployment workflow
│       ├── terraform.yaml               # Terraform provisioning workflow
│       └── terraform_all.yaml           # Workflow to apply all Terraform configurations
├── app
│   ├── Dockerfile                       # Docker configuration for the IoT application
│   ├── go.mod                           # Go module dependencies
│   ├── go.sum                           # Go module checksum file
│   └── main.go                          # Main Go application source code
├── k8s
│   └── deployments
│       ├── app.yaml                     # Kubernetes manifest for the IoT application
│       └── rabbitmq.yaml                # Kubernetes manifest for RabbitMQ
├── modules
│   ├── aws-eks-cluster-setup            # EKS cluster setup module
│   ├── aws-iot-core-setup               # IoT Core setup module
│   ├── aws-rds-setup                    # RDS setup module
│   └── aws-vpc-setup                    # VPC setup module
├── .gitignore                           # Git ignore file
├── main.tf                              # Main Terraform configuration
├── providers.tf                         # Terraform providers configuration
├── terraform.tfvars                     # Terraform variables file
├── variables.tf                         # Terraform variables definition
└── versions.tf                          # Terraform versions configuration
```

```plaintext
Each module directory under `modules/` contains the following files:

- `main.tf`: Main Terraform configuration
- `outputs.tf`: Terraform outputs
- `variables.tf`: Terraform variables
```

### Key Components

- **IoT Application**: Located in `app/`, the Go application communicates over MQTT and can be deployed as a Docker container.
- **AWS Infrastructure Modules**: Terraform modules for setting up AWS services like VPC, RDS, IoT Core, and EKS.
- **Kubernetes Deployments**: Deployment manifests for the IoT application and RabbitMQ in the `k8s/deployments/` directory.
- **CI/CD Pipelines**: GitHub Actions workflows in `.github/workflows/` for automating testing, deployment, and infrastructure provisioning.

## Getting Started

### Prerequisites

- Docker
- Terraform
- Kubernetes CLI (kubectl)
- Go (>=1.19)
- AWS CLI configured with necessary permissions

### Setting Up the Application Locally

1. **Build the Docker Image:**

    ```sh
    docker build -t sim-app-heller ./app
    ```

2. **Run the Application:**

    ```sh
    docker run -p 1883:1883 sim-app-heller
    ```

3. **Publish and Subscribe to MQTT Topics:**

    ```sh
    mosquitto_pub -h localhost -p 1883 -t test/topic -m "Hello, MQTT!"
    mosquitto_sub -h localhost -p 1883 -t test/topic
    ```

## Application

The IoT application is a lightweight service built using Go. It uses MQTT for communication and can be deployed as a Docker container or a Kubernetes pod.

## Infrastructure

This repository uses Terraform to provision cloud resources on AWS. Key modules include:

- **AWS VPC Setup** (`modules/aws-vpc-setup`): Provisions a Virtual Private Cloud.
- **AWS IoT Core Setup** (`modules/aws-iot-core-setup`): Configures AWS IoT Core for device communication.
- **AWS RDS Setup** (`modules/aws-rds-setup`): Sets up a managed relational database.
- **AWS EKS Cluster Setup** (`modules/aws-eks-cluster-setup`): Creates an Elastic Kubernetes Service cluster.

### Infrastructure Configuration

1. **Initialize Terraform:**

    ```sh
    terraform init
    ```

2. **Apply the configuration:**

    ```sh
    terraform apply
    ```

## CI/CD Pipelines

GitHub Actions workflows are defined in the `.github/workflows/` directory:

- `ci-cd-pipeline.yaml`: Automates application build and deployment.
- `rabbitmq-deploy.yaml`: Manages RabbitMQ deployment.
- `terraform.yaml`: Provisions infrastructure using Terraform.
- `terraform_all.yaml`: Applies all Terraform configurations.

## Deployment

### Manual Kubernetes Deployment

Kubernetes manifests are located in `k8s/deployments/`:

1. **Deploy the IoT application:**

    ```sh
    kubectl apply -f k8s/deployments/app.yaml
    ```

2. **Deploy RabbitMQ:**

    ```sh
    kubectl apply -f k8s/deployments/rabbitmq.yaml
    ```

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository.
2. Create a feature branch.
3. Submit a pull request.

## License

This project is licensed under the MIT License. See the LICENSE file for details.

This README provides a comprehensive overview of the project and can be easily extended as the project evolves.

terraform format
terraform validate
terraform plan
terraform apply
aws eks update-kubeconfig --region ap-northeast-1 --name sim-app-heller-eks-cluster
kubectl get nodes
aws ecr get-login-password --region ap-northeast-1 | docker login --username AWS --password-stdin 618889213523.dkr.ecr.ap-northeast-1.amazonaws.com
docker build --platform linux/amd64 -t sim-app-heller ./app
docker tag sim-app-heller:latest 618889213523.dkr.ecr.ap-northeast-1.amazonaws.com/sim-app-heller:latest
docker push 618889213523.dkr.ecr.ap-northeast-1.amazonaws.com/sim-app-heller:latest
kubectl delete -f k8s/services/app.yaml --ignore-not-found
kubectl delete -f k8s/deployments/app.yaml --ignore-not-found
kubectl apply -f k8s/deployments/app.yaml
kubectl apply -f k8s/services/app.yaml
kubectl get pods
kubectl get svc
mosquitto_pub -h {EXTERNAL-IP} -p 1883 -t test/topic -m "Hello, MQTT!"
mosquitto_sub -h {EXTERNAL-IP} -p 1883 -t test/topic

mosquitto_pub -h {EXTERNAL-IP} -p 1883 -t test/topic -m "Hello, MQTT!"
mosquitto_sub -h a8aee63b3087540cbb7679d2cdd0fc5f-1220630873.ap-northeast-1.elb.amazonaws.com -p 1883 -t test/topic

kubectl logs -l app=sim-app-heller

kubectl get svc sim-app-heller-service -o wide

kubectl describe svc sim-app-heller-service

nslookup {EXTERNAL-IP}

###

# Format Terraform files (if still relevant, otherwise skip)

terraform format

# Validate Terraform configuration (if used locally, otherwise skip)

terraform validate

# Build the Docker image locally

docker build --platform linux/amd64 -t sim-app-heller ./app

# Optionally tag the Docker image (optional for local use but useful for future pushes)

docker tag sim-app-heller:latest sim-app-heller:latest

# Run the Docker container locally

docker run -d --name sim-app-heller -p 1883:1883 -p 8080:8080 sim-app-heller:latest

# Verify the running container

docker ps

# Test MQTT locally

mosquitto_pub -h localhost -p 1883 -t test/topic -m "Hello, MQTT!"
mosquitto_sub -h localhost -p 1883 -t test/topic

# View the container logs

docker logs sim-app-heller

# Cleanup

docker stop sim-app-heller
docker rm sim-app-heller
