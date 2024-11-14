# ECR Repository
resource "aws_ecr_repository" "app_repo" {
  name         = "the-thing-app-heller"
  force_delete = true

  tags = {
    Name    = "the-thing-app-heller"
    Owner   = "Pratham Jangra"
    Project = "The Thing App Heller, PoC"
  }
}