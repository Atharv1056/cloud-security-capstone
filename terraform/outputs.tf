output "vpc_id" {
  description = "VPC identifier"
  value       = aws_vpc.main.id
}

output "alb_dns_name" {
  description = "Public DNS name for the Application Load Balancer"
  value       = aws_lb.app.dns_name
}

output "app_instance_id" {
  description = "Private EC2 instance identifier"
  value       = aws_instance.app.id
}

output "rds_endpoint" {
  description = "Private RDS endpoint (not publicly accessible)"
  value       = aws_db_instance.database.address
}

output "rds_publicly_accessible" {
  description = "Should be false"
  value       = aws_db_instance.database.publicly_accessible
}

