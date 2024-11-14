# Security Group for EKS Cluster
resource "aws_security_group" "eks_cluster_sg" {
  name        = "sim-app-heller-eks-cluster-sg"
  description = "Security group for EKS cluster"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "sim-app-heller-eks-cluster-sg"
    Owner   = "Pratham Jangra"
    Project = "Sim App PoC"
  }
}

# Security Group for Node Group
resource "aws_security_group" "node_group_sg" {
  name        = "sim-app-heller-node-group-sg"
  description = "Security group for EKS node group"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "sim-app-heller-node-group-sg"
    Owner   = "Pratham Jangra"
    Project = "Sim App PoC"
  }
}
