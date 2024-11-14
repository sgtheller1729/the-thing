output "iot_thing_name" {
  description = "The name of the IoT Thing for the vehicle"
  value       = aws_iot_thing.vehicle.name
}

output "iot_policy_name" {
  description = "The name of the IoT Policy for the vehicle"
  value       = data.aws_iot_policy.policy.name
}

output "iot_policy_document" {
  description = "The JSON document of the IoT Policy"
  value       = aws_iot_policy.policy.policy
}

output "iot_certificate_arn" {
  description = "The ARN of the IoT Certificate"
  value       = aws_iot_certificate.certificate[0].arn
}

output "iot_certificate_id" {
  description = "The ID of the IoT Certificate"
  value       = aws_iot_certificate.certificate[0].id
}

output "iot_principal_attachment_thing" {
  description = "The name of the IoT Thing attached to the certificate"
  value       = aws_iot_thing.vehicle.name
}

output "iot_principal_attachment_principal" {
  description = "The principal ARN attached to the IoT Thing"
  value       = data.aws_iot_certificate.certificate.arn
}
