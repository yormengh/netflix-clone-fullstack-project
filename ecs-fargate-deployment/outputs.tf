output "ecr_repository_urls" {
  description = "ECR repository URLs for applications"
  value       = module.ecr.repository_urls
}

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = module.alb.alb_dns_name
}

output "cloudfront_domains" {
  description = "CloudFront distribution domain names"
  value       = module.cloudfront.cloudfront_domains
}