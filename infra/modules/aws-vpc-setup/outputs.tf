# VPC ID
output "vpc_id" {
  value       = aws_vpc.vpc.id
  description = "The ID of the shared VPC"
}

# Internet Gateway ID
output "internet_gateway_id" {
  value       = aws_internet_gateway.igw.id
  description = "The ID of the Internet Gateway"
}

# Public Subnet IDs
output "public_subnet_ids" {
  value       = [for subnet in aws_subnet.public_subnets : subnet.id]
  description = "The IDs of the public subnets"
}

# Private Subnet IDs
output "private_subnet_ids" {
  value       = [for subnet in aws_subnet.private_subnets : subnet.id]
  description = "The IDs of the private subnets"
}

# Public Route Table ID
output "public_route_table_id" {
  value       = aws_route_table.public_route_table.id
  description = "The ID of the public route table"
}

# Private Route Table ID
output "private_route_table_id" {
  value       = aws_route_table.private_route_table.id
  description = "The ID of the private route table"
}

# NAT Gateway ID
output "nat_gateway_id" {
  value       = aws_nat_gateway.nat_gw.id
  description = "The ID of the NAT Gateway"
}

# NAT Gateway EIP
output "nat_gateway_eip" {
  value       = aws_eip.nat_eip.public_ip
  description = "The Elastic IP address of the NAT Gateway"
}

# Availability Zones
output "availability_zones" {
  value       = data.aws_availability_zones.available.names
  description = "The availability zones used in this deployment"
}

# CIDR Block for VPC
output "vpc_cidr_block" {
  value       = aws_vpc.vpc.cidr_block
  description = "The CIDR block of the VPC"
}
