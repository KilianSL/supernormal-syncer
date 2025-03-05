output "api_public_ip" {
  description = "Public IP address of the API server"
  value       = aws_eip.api_eip.public_ip
}

output "api_dns" {
  description = "Public DNS of the API server"
  value       = aws_instance.api_instance.public_dns
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.api_vpc.id
}

output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.api_sg.id
} 