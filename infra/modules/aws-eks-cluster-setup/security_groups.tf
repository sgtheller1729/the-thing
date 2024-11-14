# Security Group for EKS Cluster
resource "aws_security_group" "eks_cluster_sg" {
  name        = "iot-app-jpg-eks-cluster-sg"
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
    Name    = "iot-app-jpg-eks-cluster-sg"
    Owner   = "Pratham Jangra"
    Project = "The Thing App Heller, PoC"
  }
}

# Security Group for Node Group
resource "aws_security_group" "node_group_sg" {
  name        = "iot-app-jpg-node-group-sg"
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
    Name    = "iot-app-jpg-node-group-sg"
    Owner   = "Pratham Jangra"
    Project = "The Thing App Heller, PoC"
  }
}