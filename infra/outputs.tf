output "region" {
  description = "The AWS region where resources will be created"
  value       = var.region
}

output "eks_cluster_name" {
  description = "The name of the EKS cluster"
  value       = module.eks.eks_cluster_name
}

output "nlb_name" {
  value = module.eks.nlb_name
}

output "mqtt_target_group_arn" {
  value = module.eks.mqtt_target_group_arn
}

output "html_target_group_arn" {
  value = module.eks.html_target_group_arn
}
