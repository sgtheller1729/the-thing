# Subnet Group for the Database
resource "aws_db_subnet_group" "db_subnet_group" {
  name        = "iot-app-jpg-db-subnet-group"
  description = "Subnet group for the PostgreSQL database"
  subnet_ids  = var.private_subnet_ids

  tags = {
    Name    = "iot-app-jpg-db-subnet-group"
    Owner   = "Pratham Jangra"
    Project = "The Thing App Heller, PoC"
  }
}

# Security Group for Database
resource "aws_security_group" "db_security_group" {
  name        = "iot-app-jpg-db-security-group"
  description = "Allow access to the IoT app database"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "iot-app-jpg-db-security-group"
    Owner   = "Pratham Jangra"
    Project = "The Thing App Heller, PoC"
  }
}

# PostgreSQL RDS Instance
resource "aws_db_instance" "postgres_instance" {
  identifier             = "iot-app-jpg-postgres-db"
  engine                 = "postgres"
  engine_version         = "16.4"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  storage_type           = "gp2"
  username               = "iot_app_admin"
  password               = "YourPassword123!"
  db_name                = "iot_app_database"
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.db_security_group.id]
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name

  tags = {
    Name    = "iot-app-jpg-postgres-instance"
    Owner   = "Pratham Jangra"
    Project = "The Thing App Heller, PoC"
  }
}