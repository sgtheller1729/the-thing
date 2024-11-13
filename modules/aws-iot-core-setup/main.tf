provider "aws" {
  region = "ap-northeast-1"  # Change to your desired region
}

# Define an IoT Thing
resource "aws_iot_thing" "my_iot_thing" {
  name = "MyIoTThing"
}

# Define an IoT Policy
resource "aws_iot_policy" "my_iot_policy" {
  name   = "MyIoTPolicy"
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
        Resource = "*"
      }
    ]
  })
}

# Create an IoT Certificate
resource "aws_iot_certificate" "my_iot_certificate" {
  count = 1

  active = true
}

# Attach the certificate to the IoT Thing
resource "aws_iot_thing_principal_attachment" "thing_cert_attachment" {
  thing_name = aws_iot_thing.my_iot_thing.name
  principal  = aws_iot_certificate.my_iot_certificate[0].arn
}

# Attach the policy to the IoT Certificate
resource "aws_iot_policy_attachment" "policy_attachment" {
  policy_name = aws_iot_policy.my_iot_policy.name
  principal   = aws_iot_certificate.my_iot_certificate[0].arn
}