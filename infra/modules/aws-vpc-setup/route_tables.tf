
# Public Route Table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.public_internet_cidr
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name    = "the-thing-app-heller-public-rt"
    Owner   = "Pratham Jangra"
    Project = "The Thing App Heller, PoC"
  }

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table_association" "public_subnet_association" {
  for_each       = aws_subnet.public_subnets
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_route_table.id

  depends_on = [aws_route_table.public_route_table, aws_subnet.public_subnets]
}

# Private Route Table
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = var.public_internet_cidr
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name    = "the-thing-app-heller-private-rt"
    Owner   = "Pratham Jangra"
    Project = "The Thing App Heller, PoC"
  }

  depends_on = [aws_nat_gateway.nat_gw]
}

resource "aws_route_table_association" "private_subnet_association" {
  for_each       = aws_subnet.private_subnets
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private_route_table.id

  depends_on = [aws_route_table.private_route_table, aws_subnet.private_subnets]
}
