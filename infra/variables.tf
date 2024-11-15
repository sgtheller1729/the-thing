variable "region" {
  description = "The AWS region"
  type        = string
}

# aws-iot-core-setup
variable "vehicle_id" {
  description = "Unique identifier for the vehicle"
  type        = string
}

variable "model" {
  description = "Vehicle model"
  type        = string
}

variable "account_id" {
  description = "AWS Account ID"
  type        = string
}

# aws-vpc-setup
variable "subnet_count" {
  description = "Number of subnets to create"
  type        = number
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for the public subnets"
  type        = list(string)

  validation {
    condition     = length(var.public_subnet_cidrs) == var.subnet_count
    error_message = "The number of public subnet CIDRs must match the subnet_count variable."
  }
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for the private subnets"
  type        = list(string)

  validation {
    condition     = length(var.private_subnet_cidrs) == var.subnet_count
    error_message = "The number of private subnet CIDRs must match the subnet_count variable."
  }
}

variable "public_internet_cidr" {
  description = "CIDR block for public internet access"
  type        = string
}
