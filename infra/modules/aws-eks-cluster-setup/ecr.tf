# ECR Repository
resource "aws_ecr_repository" "app_repo" {
  name         = "sim-app-heller"
  force_delete = true

  tags = {
    Name    = "sim-app-heller"
    Owner   = "Pratham Jangra"
    Project = "Sim App PoC"
  }
}
