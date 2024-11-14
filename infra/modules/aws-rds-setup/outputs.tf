output "db_instance_identifier" {
  description = "The identifier of the PostgreSQL database instance"
  value       = aws_db_instance.postgres_instance.identifier
}

output "db_instance_endpoint" {
  description = "The endpoint of the PostgreSQL database instance"
  value       = aws_db_instance.postgres_instance.endpoint
}

output "db_instance_port" {
  description = "The port of the PostgreSQL database instance"
  value       = aws_db_instance.postgres_instance.port
}

output "db_security_group_id" {
  description = "The ID of the security group associated with the PostgreSQL database"
  value       = aws_security_group.db_security_group.id
}

output "db_subnet_group_name" {
  description = "The name of the subnet group associated with the PostgreSQL database"
  value       = aws_db_subnet_group.db_subnet_group.name
}
