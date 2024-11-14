# IAM Roles and Policies for EKS Cluster
data "aws_iam_role" "eks_role" {
  name = "iot-app-jpg-eks-cluster-role"
}

data "aws_iam_policy" "eks_policy" {
  arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

# IAM Roles and Policies for Node Group
data "aws_iam_role" "node_role" {
  name = "iot-app-jpg-node-group-role"
}

data "aws_iam_policy" "node_policies" {
  for_each = {
    eks_worker_policy = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
    ecr_read_only     = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    eks_cni_policy    = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    ssm_core_policy   = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }

  arn = each.value
}