variable "app_name" {
  description = "Application name prefix"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_subnets" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "ecs_sg_id" {
  description = "ECS Security Group ID"
  type        = string
}

variable "repository_urls" {
  description = "ECR repository URLs for applications"
  type        = list(string)
}

variable "alb_listener_arn" {
  description = "ALB HTTPS Listener ARN"
  type        = string
}

variable "target_group_arns" {
  description = "Target Group ARNs"
  type        = list(string)
}