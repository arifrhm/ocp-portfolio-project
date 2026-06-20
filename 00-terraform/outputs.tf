output "vpc_id" {
  description = "The ID of the VPC created for OpenShift"
  value       = aws_vpc.ocp_vpc.id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = aws_subnet.private[*].id
}
