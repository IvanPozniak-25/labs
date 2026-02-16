terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"

    }
  }
}
provider "aws" {
    region = "us-east-2"
    allowed_account_ids = [local.account.id]
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "main_test_vpc"
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
  instance_type = "t2.micro"
    ami           = "ami-03ea746da1a2e36e7"
}