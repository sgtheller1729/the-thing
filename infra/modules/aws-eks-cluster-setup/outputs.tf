# EKS Cluster Outputs
output "eks_cluster_name" {
  description = "The name of the EKS cluster"
  value       = aws_eks_cluster.eks_cluster.name
}

output "eks_cluster_endpoint" {
  description = "The endpoint for the EKS cluster"
  value       = aws_eks_cluster.eks_cluster.endpoint
}

output "eks_cluster_certificate_authority_data" {
  description = "The certificate authority data for the EKS cluster"
  value       = aws_eks_cluster.eks_cluster.certificate_authority.0.data
}

# output "eks_cluster_arn" {
#   description = "The ARN of the EKS cluster"
#   value       = aws_eks_cluster.eks_cluster.arn
# }

# output "eks_cluster_role_arn" {
#   description = "The ARN of the IAM role assigned to the EKS cluster"
#   value       = data.aws_iam_role.eks_role.arn
# }

# # EKS Node Group Outputs
# output "node_group_name" {
#   description = "The name of the managed node group"
#   value       = aws_eks_node_group.node_group.node_group_name
# }

# output "node_group_role_arn" {
#   description = "The ARN of the IAM role assigned to the managed node group"
#   value       = data.aws_iam_role.node_role.arn
# }

# output "node_group_instance_types" {
#   description = "The instance types for the managed node group"
#   value       = aws_eks_node_group.node_group.instance_types
# }

# output "node_group_desired_size" {
#   description = "The desired size of the managed node group"
#   value       = aws_eks_node_group.node_group.scaling_config[0].desired_size
# }

# output "node_group_max_size" {
#   description = "The maximum size of the managed node group"
#   value       = aws_eks_node_group.node_group.scaling_config[0].max_size
# }

# output "node_group_min_size" {
#   description = "The minimum size of the managed node group"
#   value       = aws_eks_node_group.node_group.scaling_config[0].min_size
# }

# # ECR Repository Outputs
# output "ecr_repository_url" {
#   description = "The URL of the ECR repository"
#   value       = aws_ecr_repository.app_repo.repository_url
# }

# output "ecr_repository_name" {
#   description = "The name of the ECR repository"
#   value       = aws_ecr_repository.app_repo.name
# }

# output "ecr_repository_arn" {
#   description = "The ARN of the ECR repository"
#   value       = aws_ecr_repository.app_repo.arn
# }

# NLB Outputs
output "nlb_name" {
  value = aws_lb.app_nlb.name
}

output "alb_name" {
  value = aws_lb.app_alb.name
}

output "mqtt_target_group_arn" {
  value = aws_lb_target_group.nlb_mqtt_tg.arn
}

output "html_target_group_arn" {
  value = aws_lb_target_group.alb_http_tg.arn
}
