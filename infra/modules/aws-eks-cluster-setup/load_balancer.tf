# Load Balancer
resource "aws_lb" "app_nlb" {
  name               = "the-thing-app-heller-nlb"
  internal           = false
  load_balancer_type = "network"
  subnets            = var.public_subnet_ids

  enable_deletion_protection = false

  tags = {
    Name    = "the-thing-app-heller-nlb"
    Owner   = "Pratham Jangra"
    Project = "The Thing App, PoC"
  }
}

resource "aws_security_group" "app_nlb_sg" {
  name        = "the-thing-app-heller-nlb-sg"
  description = "Security group for NLB"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

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
    Name    = "the-thing-app-heller-nlb-sg"
    Owner   = "Pratham Jangra"
    Project = "The Thing App, PoC"
  }
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.app_nlb.arn
  port              = 8080
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.html_tg.arn
  }
}

resource "aws_lb_listener" "mqtt_listener" {
  load_balancer_arn = aws_lb.app_nlb.arn
  port              = 1883
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.mqtt_tg.arn
  }
}

resource "aws_lb_target_group" "html_tg" {
  name     = "the-thing-app-html-tg"
  port     = 8080
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
    Name    = "the-thing-app-html-tg"
    Owner   = "Pratham Jangra"
    Project = "The Thing App, PoC"
  }
}

resource "aws_lb_target_group" "mqtt_tg" {
  name     = "the-thing-app-mqtt-tg"
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
    Name    = "the-thing-app-mqtt-tg"
    Owner   = "Pratham Jangra"
    Project = "The Thing App, PoC"
  }
}
