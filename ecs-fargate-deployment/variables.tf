variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "app_name" {
  description = "Application name prefix"
  type        = string
  default     = "myapp"
}

variable "domain_name" {
  description = "Domain name for Route 53 and CloudFront"
  type        = string
  default     = "example.com"
}

variable "hosted_zone_id" {
  description = "Route 53 Hosted Zone ID"
  type        = string
}