terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"

    }
  }
}
provider "aws" {
    region = "eu-north-1"
    allowed_account_ids = [local.account.id]
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "main_test_vpc"
  }
}

resource "aws_eip" "test_eip" {
  instance = "${aws_instance.test_ec2.id}"
  domain = "vpc"

  tags = {
        Name = "test_eip"
    }
}

resource "aws_subnet" "public_subnetes" {
  vpc_id = aws_vpc.main.id
  count = length(var.public_subnet_cidrs)
  cidr_block = element(var.public_subnet_cidrs, count.index)
  tags = {
    Name = "Public_Subnet_${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnetes" {
  vpc_id = aws_vpc.main.id
  count = length(var.private_subnet_cidrs)
  cidr_block = element(var.private_subnet_cidrs, count.index)
  tags = {
    Name = "Private_Subnet_${count.index + 1}"
  }
}

resource "aws_instance" "test_ec2" {
  ami                         = "ami-0c83cb1c664994bbd"
  instance_type               = "t3.micro"
  subnet_id     = element(aws_subnet.public_subnetes[*].id, 0)
  security_groups = ["${aws_security_group.test_sequrity_group.id}"]
  tags = {
        Name = "test_ec2"
      }
}

resource "aws_internet_gateway" "test_gateway" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "test_gateway"
  }
}

resource "aws_security_group" "test_sequrity_group" {
    name        = "test_security_group"
    description = "Allow SSH and HTTP"
    vpc_id      = aws_vpc.main.id
    ingress {
        from_port   = 24
        to_port     = 24
        protocol    = "tcp"
        cidr_blocks = var.public_subnet_cidrs
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = var.public_subnet_cidrs
    }
    tags = {
        Name = "test_security_group"
      }
}

resource "aws_route_table" "test_route_table" {
  vpc_id         = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test_gateway.id
  }
  tags = {
    Name = "test_route_table"
  }
}

resource "aws_route_table_association" "test_route_table_association" {
  count = length(var.public_subnet_cidrs)
  route_table_id = aws_route_table.test_route_table.id
  subnet_id      = element(aws_subnet.public_subnetes[*].id, count.index)
}
