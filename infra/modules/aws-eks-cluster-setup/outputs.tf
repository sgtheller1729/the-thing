# EKS Cluster Details
output "cluster_name" {
  description = "EKS Cluster Name"
  value       = aws_eks_cluster.eks_cluster.name
}

output "cluster_endpoint" {
  description = "EKS Cluster API Endpoint"
  value       = aws_eks_cluster.eks_cluster.endpoint
}

output "cluster_arn" {
  description = "EKS Cluster ARN"
  value       = aws_eks_cluster.eks_cluster.arn
}

output "cluster_role_arn" {
  description = "IAM Role ARN for EKS Cluster"
  value       = data.aws_iam_role.eks_role.arn
}

# Node Group Details
output "group_name" {
  description = "Node Group Name"
  value       = aws_eks_node_group.node_group.node_group_name
}

output "group_role_arn" {
  description = "IAM Role ARN for Node Group"
  value       = data.aws_iam_role.node_role.arn
}

output "group_instance_types" {
  description = "Instance Types for Node Group"
  value       = aws_eks_node_group.node_group.instance_types
}

output "group_desired_size" {
  description = "Desired Node Group Size"
  value       = aws_eks_node_group.node_group.scaling_config[0].desired_size
}

output "group_max_size" {
  description = "Max Node Group Size"
  value       = aws_eks_node_group.node_group.scaling_config[0].max_size
}

output "group_min_size" {
  description = "Min Node Group Size"
  value       = aws_eks_node_group.node_group.scaling_config[0].min_size
}

# ECR Repository Info
output "repo_url" {
  description = "ECR Repository URL"
  value       = aws_ecr_repository.app_repo.repository_url
}

output "repo_name" {
  description = "ECR Repository Name"
  value       = aws_ecr_repository.app_repo.name
}

output "repo_arn" {
  description = "ECR Repository ARN"
  value       = aws_ecr_repository.app_repo.arn
}

# Network Load Balancer (NLB) Details
output "nlb_name" {
  description = "NLB Name"
  value       = aws_lb.app_nlb.name
}

output "tg_mqtt_arn" {
  description = "MQTT Target Group ARN"
  value       = aws_lb_target_group.mqtt_tg.arn
}

output "tg_html_arn" {
  description = "HTML Target Group ARN"
  value       = aws_lb_target_group.html_tg.arn
}
