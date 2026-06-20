variable "aws_region" {
  description = "AWS region for OpenShift infrastructure"
  type        = string
  default     = "ap-southeast-1"
}

variable "environment" {
  description = "Environment name (e.g. dev, staging, prod)"
  type        = string
  default     = "production"
}

variable "vpc_cidr" {
  description = "CIDR block for the OpenShift VPC"
  type        = string
  default     = "10.0.0.0/16"
}
