output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.main.dns_name
}

output "alb_zone_id" {
  description = "Zone ID of the Application Load Balancer"
  value       = aws_lb.main.zone_id
}

output "listener_https_arn" {
  description = "HTTPS Listener ARN"
  value       = aws_lb_listener.https.arn
}

output "target_group_arns" {
  description = "Target Group ARNs"
  value       = aws_lb_target_group.app[*].arn
}