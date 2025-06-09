output "cloudfront_domains" {
  description = "CloudFront distribution domain names"
  value       = [for dist in aws_cloudfront_distribution.frontend : dist.domain_name]
}