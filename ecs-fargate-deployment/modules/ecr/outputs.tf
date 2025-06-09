output "repository_urls" {
  description = "ECR repository URLs for applications"
  value       = [for repo in aws_ecr_repository.app : repo.repository_url]
}