resource "aws_lb" "app_alb" {
  name               = "sim-app-heller-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.app_alb_sg.id]
  subnets            = var.public_subnet_ids

  tags = {
    Name    = "sim-app-heller-alb"
    Owner   = "Pratham Jangra"
    Project = "Sim App PoC"
  }
}

resource "aws_security_group" "app_alb_sg" {
  name        = "sim-app-heller-alb-sg"
  description = "Security group for ALB"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 8080
    to_port     = 8080
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
    Name    = "sim-app-heller-alb-sg"
    Owner   = "Pratham Jangra"
    Project = "Sim App PoC"
  }
}

resource "aws_lb_listener" "alb_http_listener" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = 8080
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_http_tg.arn
  }
}

resource "aws_lb_target_group" "alb_http_tg" {
  name     = "iot-app-http-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    protocol            = "HTTP"
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 2
  }

  tags = {
    Name    = "iot-app-http-tg"
    Owner   = "Pratham Jangra"
    Project = "Sim App PoC"
  }
}

resource "aws_lb" "app_nlb" {
  name               = "sim-app-heller-nlb"
  internal           = false
  load_balancer_type = "network"
  subnets            = var.public_subnet_ids

  enable_deletion_protection = false

  tags = {
    Name    = "sim-app-heller-nlb"
    Owner   = "Pratham Jangra"
    Project = "Sim App PoC"
  }
}

resource "aws_security_group" "app_nlb_sg" {
  name        = "sim-app-heller-nlb-sg"
  description = "Security group for NLB"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 1883
    to_port     = 1883
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
    Name    = "sim-app-heller-nlb-sg"
    Owner   = "Pratham Jangra"
    Project = "Sim App PoC"
  }
}

resource "aws_lb_listener" "nlb_mqtt_listener" {
  load_balancer_arn = aws_lb.app_nlb.arn
  port              = 1883
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nlb_mqtt_tg.arn
  }
}

resource "aws_lb_target_group" "nlb_mqtt_tg" {
  name     = "iot-app-mqtt-tg"
  port     = 1883
  protocol = "TCP"
  vpc_id   = var.vpc_id

  health_check {
    protocol            = "TCP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 2
  }

  tags = {
    Name    = "iot-app-mqtt-tg"
    Owner   = "Pratham Jangra"
    Project = "Sim App PoC"
  }
}
