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

resource "aws_instance" "CPD-01-env" {
  ami                         = "ami-04e49054bb647a8ed" # заміни на ту, що у твоєму інстансі
  instance_type               = "t3.micro"
  associate_public_ip_address = true

  tags = {
    Name = "CPD-01-env"
  }
}