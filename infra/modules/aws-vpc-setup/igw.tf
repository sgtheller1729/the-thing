# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name    = "sim-app-heller-igw"
    Owner   = "Pratham Jangra"
    Project = "Sim App PoC"
  }

  depends_on = [aws_vpc.vpc]
}
