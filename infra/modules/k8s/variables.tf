variable "nlb_name" {
  description = "The name of the Network Load Balancer."
  type        = string
}

variable "alb_name" {
  description = "The name of the Application Load Balancer."
  type        = string

}

variable "mqtt_target_group_arn" {
  description = "The ARN of the MQTT target group."
  type        = string
}

variable "html_target_group_arn" {
  description = "The ARN of the HTML target group."
  type        = string
}
