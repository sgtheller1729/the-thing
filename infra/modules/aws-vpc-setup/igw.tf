# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name    = "iot-app-jpg-igw"
    Owner   = "Pratham Jangra"
    Project = "The Thing App Heller, PoC"
  }

  depends_on = [aws_vpc.vpc]
}
