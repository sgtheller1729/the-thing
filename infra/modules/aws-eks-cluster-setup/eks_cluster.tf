# EKS Cluster
resource "aws_eks_cluster" "eks_cluster" {
  name     = "sim-app-heller-eks-cluster"
  role_arn = data.aws_iam_role.eks_role.arn

  vpc_config {
    subnet_ids         = var.private_subnet_ids
    security_group_ids = [aws_security_group.eks_cluster_sg.id]
  }

  depends_on = [
    data.aws_iam_policy.eks_policy,
    aws_security_group.eks_cluster_sg
  ]

  tags = {
    Name    = "sim-app-heller-eks-cluster"
    Owner   = "Pratham Jangra"
    Project = "Sim App PoC"
  }
}
