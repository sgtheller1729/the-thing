# ECR Repository URL
locals {
  ecr_repository_url = "${var.aws_account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/sim-app-heller"
}

# Pull base image
resource "docker_image" "base_image" {
  name = "ubuntu:latest"
}

# Build Docker image
resource "docker_image" "app_image" {
  name = "sim-app-heller:latest"
  build {
    context  = "${path.root}/../simulator"
    platform = "linux/amd64"
  }
}

# Tag Docker image
resource "docker_tag" "ecr_tag" {
  source_image = docker_image.app_image.name
  target_image = "${local.ecr_repository_url}:latest"
}

# Push Docker image
resource "docker_registry_image" "ecr_push" {
  name = docker_tag.ecr_tag.target_image
}
