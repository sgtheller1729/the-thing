# NAT Gateway and Elastic IP
resource "aws_eip" "nat_eip" {
  tags = {
    Name    = "the-thing-app-nat-eip"
    Owner   = "Pratham Jangra"
    Project = "The Thing App Heller, PoC"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = values(aws_subnet.public_subnets)[0].id # Access the first public subnet

  tags = {
    Name    = "the-thing-app-nat-gw"
    Owner   = "Pratham Jangra"
    Project = "The Thing App Heller, PoC"
  }

  depends_on = [aws_eip.nat_eip, aws_subnet.public_subnets]
}
