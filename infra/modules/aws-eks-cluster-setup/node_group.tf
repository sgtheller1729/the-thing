# Node Group
resource "aws_eks_node_group" "node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "the-thing-app-heller-node-group"
  subnet_ids      = var.private_subnet_ids
  node_role_arn   = data.aws_iam_role.node_role.arn

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 0
  }

  instance_types = ["t3.medium"]
  capacity_type  = "SPOT"

  ami_type = "AL2_x86_64"

  depends_on = [
    aws_eks_cluster.eks_cluster,
    data.aws_iam_policy.node_policies
  ]

  tags = {
    Name    = "the-thing-app-heller-node-group"
    Owner   = "Pratham Jangra"
    Project = "The Thing App Heller, PoC"
  }
}