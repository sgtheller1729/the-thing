# IoT Thing Resources
resource "aws_iot_thing" "vehicle" {
  name = "sim-app-heller-vehicle-${var.vehicle_id}"
}

data "aws_iot_certificate" "certificate" {
  arn = aws_iot_certificate.certificate[0].arn
}

# IoT Policy Resources
resource "aws_iot_policy" "policy" {
  name = "sim-app-heller-policy-${var.vehicle_id}"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "iot:Connect",
          "iot:Publish",
          "iot:Subscribe",
          "iot:Receive"
        ]
        Resource = [
          "arn:aws:iot:ap-northeast-1:${var.account_id}:topic/${var.model}/${var.vehicle_id}/#"
        ]
      },
      {
        Effect   = "Allow"
        Action   = "iot:Connect"
        Resource = "arn:aws:iot:ap-northeast-1:${var.account_id}:client/${var.vehicle_id}"
      }
    ]
  })

  tags = {
    Name    = "sim-app-heller-policy-${var.vehicle_id}"
    Owner   = "Pratham Jangra"
    Project = "Sim App PoC"
  }
}

data "aws_iot_policy" "policy" {
  name = "sim-app-heller-policy-${var.vehicle_id}"
}

# IoT Certificate Resources
resource "aws_iot_certificate" "certificate" {
  count  = 1
  active = true
}
