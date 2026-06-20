provider "aws" {
  region = var.aws_region
}

# Example VPC Foundation for OpenShift (ROSA)
resource "aws_vpc" "ocp_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "ocp-vpc"
    Environment = var.environment
  }
}

resource "aws_subnet" "public" {
  count                   = 3
  vpc_id                  = aws_vpc.ocp_vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "ocp-public-subnet-${count.index}"
  }
}

resource "aws_subnet" "private" {
  count             = 3
  vpc_id            = aws_vpc.ocp_vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, count.index + 3)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "ocp-private-subnet-${count.index}"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}
