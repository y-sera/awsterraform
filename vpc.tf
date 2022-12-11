##==============================
## Resource: VPC
## Ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
##==============================

variable "vpc" {
  type = object({
    cidr = string
    name = string
  })
}

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc.cidr

  tags = {
    Name = var.vpc.name
  }
}

output "vpc" {
  value = {
    cidr_block = aws_vpc.vpc.cidr_block
    id = aws_vpc.vpc.id
    tags = aws_vpc.vpc.tags_all
  }
}


##=====================================
## Resource: Subnet 
## Ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet 
## Required: vpc_id, 
##=====================================

variable "public_subnet_1a" {
  type = object({
    cidr = string
    name = string
    az = string
  })
}

variable "private_subnet_1a" {
  type = object({
    cidr = string
    name = string
    az = string 
  })
}

resource "aws_subnet" "public_subnet_1a" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.public_subnet_1a.cidr
  availability_zone = var.public_subnet_1a.az  

  tags = {
    Name = var.public_subnet_1a.name
  } 
}

resource "aws_subnet" "private_subnet_1a" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.private_subnet_1a.cidr
  availability_zone = var.private_subnet_1a.az

  tags = {
    Name = var.private_subnet_1a.name
  }
}

output "public_subnet_1a" {
  value = {
    subnet_id = aws_subnet.public_subnet_1a.id
    az = aws_subnet.public_subnet_1a.availability_zone 
    tags = aws_subnet.public_subnet_1a.tags_all
  }
}

output "private_subnet_1a" {
  value = {
    subnet_id = aws_subnet.private_subnet_1a.id
    az = aws_subnet.private_subnet_1a.availability_zone 
    tags = aws_subnet.private_subnet_1a.tags_all
  }
}

