terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}


# vpc
resource "aws_vpc" "dev-vpc" {
  cidr_block           = "10.123.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "Dev-VPC"

  }
}

# subnet (public)
resource "aws_subnet" "dev_public_subnet" {
  vpc_id                  = aws_vpc.dev-vpc.id
  cidr_block              = "10.123.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "Dev-Public-Subnet1"
  }
}

# internet gateway 
resource "aws_internet_gateway" "dev_igw" {
  vpc_id = aws_vpc.dev-vpc.id

  tags = {
    Name = "dev-igw"
  }
}

# route table (table, route & association)
resource "aws_route_table" "dev_rt" {
  vpc_id = aws_vpc.dev-vpc.id

  tags = {
    Name = "dev-route"
  }
}

resource "aws_route" "dev_route" {
  route_table_id         = aws_route_table.dev_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.dev_igw.id

}

resource "aws_route_table_association" "dev_a" {
  subnet_id      = aws_subnet.dev_public_subnet.id
  route_table_id = aws_route_table.dev_rt.id
}

