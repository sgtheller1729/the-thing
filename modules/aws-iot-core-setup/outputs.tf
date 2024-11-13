output "thing_name" {
  value = aws_iot_thing.my_iot_thing.name
}

output "certificate_arn" {
  value = aws_iot_certificate.my_iot_certificate[0].arn
}

output "policy_arn" {
  value = aws_iot_policy.my_iot_policy.arn
}
