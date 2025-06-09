variable "app_name" {
  description = "Application name prefix"
  type        = string
}

variable "domain_name" {
  description = "Domain name for CloudFront"
  type        = string
}

variable "alb_dns_name" {
  description = "ALB DNS name"
  type        = string
}

variable "certificate_arn" {
  description = "ACM Certificate ARN"
  type        = string
}