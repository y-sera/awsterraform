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

variable "pub_sub_1a" {
  type = object({
    cidr = string
    name = string
    az = string
  })
}

variable "pri_sub_1a" {
  type = object({
    cidr = string
    name = string
    az = string 
  })
}

resource "aws_subnet" "pub_sub_1a" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.pub_sub_1a.cidr
  availability_zone = var.pub_sub_1a.az  

  tags = {
    Name = var.pub_sub_1a.name
  } 
}

resource "aws_subnet" "pri_sub_1a" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.pri_sub_1a.cidr
  availability_zone = var.pri_sub_1a.az

  tags = {
    Name = var.pri_sub_1a.name
  }
}

output "pub_sub_1a" {
  value = {
    subnet_id = aws_subnet.pub_sub_1a.id
    az = aws_subnet.pub_sub_1a.availability_zone 
    tags = aws_subnet.pub_sub_1a.tags_all
  }
}

output "pri_sub_1a" {
  value = {
    subnet_id = aws_subnet.pri_sub_1a.id
    az = aws_subnet.pri_sub_1a.availability_zone 
    tags = aws_subnet.pri_sub_1a.tags_all
  }
}

##==============================
## Resourece: Internet Gateway
## Ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway
##==============================

variable igw_name {}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.igw_name
  }
}

output "igw" {
  value = aws_internet_gateway.igw.id
}
