variable "app_name" {
  description = "Application name prefix"
  type        = string
}

variable "domain_name" {
  description = "Domain name for Route 53"
  type        = string
}

variable "hosted_zone_id" {
  description = "Route 53 Hosted Zone ID"
  type        = string
}

variable "alb_dns_name" {
  description = "ALB DNS name"
  type        = string
}

variable "alb_zone_id" {
  description = "ALB Zone ID"
  type        = string
}

variable "cloudfront_domains" {
  description = "CloudFront distribution domain names"
  type        = list(string)
}