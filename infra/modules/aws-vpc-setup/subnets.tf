# Data
data "aws_availability_zones" "available" {}

# Public Subnets
resource "aws_subnet" "public_subnets" {
  for_each                = toset(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = each.value
  availability_zone       = element(data.aws_availability_zones.available.names, index(var.public_subnet_cidrs, each.value))
  map_public_ip_on_launch = true

  tags = {
    Name    = "the-thing-app-heller-public-subnet-${index(var.public_subnet_cidrs, each.value)}"
    Owner   = "Pratham Jangra"
    Project = "The Thing App Heller, PoC"
  }

  depends_on = [aws_vpc.vpc]
}

# Private Subnets
resource "aws_subnet" "private_subnets" {
  for_each          = toset(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.value
  availability_zone = element(data.aws_availability_zones.available.names, index(var.private_subnet_cidrs, each.value))

  tags = {
    Name    = "the-thing-app-heller-private-subnet-${index(var.private_subnet_cidrs, each.value)}"
    Owner   = "Pratham Jangra"
    Project = "The Thing App Heller, PoC"
  }

  depends_on = [aws_vpc.vpc]
}
