##==============================
## Resource: VPC
## Ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
##==============================

variable "vpc2" {
  type = object({
    cidr = string
    name = string
  })
}

resource "aws_vpc" "vpc2" {
  cidr_block = var.vpc2.cidr
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc2.name
  }
}

output "vpc2" {
  value = aws_vpc.vpc2.cidr_block
}


##=====================================
## Resource: Subnet
## Ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
## Required: vpc_id,
##=====================================

variable "vpc2_pri_sub_1a" {
  type = object({
    cidr = string
    name = string
    az = string
  })
}

variable "vpc2_pri_sub_1c" {
  type = object({
    cidr = string
    name = string
    az = string
  })
}

variable "vpc2_dmzi_sub_1a" {
  type = object({
    cidr = string
    name = string
    az = string
  })
}

variable "vpc2_dmzi_sub_1c" {
  type = object({
    cidr = string
    name = string
    az = string
  })
}
variable "vpc2_dmze_sub_1a" {
  type = object({
    cidr = string
    name = string
    az = string
  })
}
variable "vpc2_dmze_sub_1c" {
  type = object({
    cidr = string
    name = string
    az = string
  })
}
variable "vpc2_tgw_sub_1a" {
  type = object({
    cidr = string
    name = string
    az = string
  })
}
variable "vpc2_tgw_sub_1c" {
  type = object({
    cidr = string
    name = string
    az = string
  })
}


resource "aws_subnet" "vpc2_pri_sub_1a" {
  vpc_id = aws_vpc.vpc2.id
  cidr_block = var.vpc2_pri_sub_1a.cidr
  availability_zone = var.vpc2_pri_sub_1a.az

  tags = {
    Name = var.vpc2_pri_sub_1a.name
  }
}

resource "aws_subnet" "vpc2_pri_sub_1c" {
  vpc_id = aws_vpc.vpc2.id
  cidr_block = var.vpc2_pri_sub_1c.cidr
  availability_zone = var.vpc2_pri_sub_1c.az

  tags = {
    Name = var.vpc2_pri_sub_1c.name
  }
}

resource "aws_subnet" "vpc2_dmzi_sub_1a" {
  vpc_id = aws_vpc.vpc2.id
  cidr_block = var.vpc2_dmzi_sub_1a.cidr
  availability_zone = var.vpc2_dmzi_sub_1a.az

  tags = {
    Name = var.vpc2_dmzi_sub_1a.name
  }
}

resource "aws_subnet" "vpc2_dmzi_sub_1c" {
  vpc_id = aws_vpc.vpc2.id
  cidr_block = var.vpc2_dmzi_sub_1c.cidr
  availability_zone = var.vpc2_dmzi_sub_1c.az

  tags = {
    Name = var.vpc2_dmzi_sub_1c.name
  }
}

resource "aws_subnet" "vpc2_dmze_sub_1a" {
  vpc_id = aws_vpc.vpc2.id
  cidr_block = var.vpc2_dmze_sub_1a.cidr
  availability_zone = var.vpc2_dmze_sub_1a.az

  tags = {
    Name = var.vpc2_dmze_sub_1a.name
  }
}

resource "aws_subnet" "vpc2_dmze_sub_1c" {
  vpc_id = aws_vpc.vpc2.id
  cidr_block = var.vpc2_dmze_sub_1c.cidr
  availability_zone = var.vpc2_dmze_sub_1c.az

  tags = {
    Name = var.vpc2_dmze_sub_1c.name
  }
}

resource "aws_subnet" "vpc2_tgw_sub_1a" {
  vpc_id = aws_vpc.vpc2.id
  cidr_block = var.vpc2_tgw_sub_1a.cidr
  availability_zone = var.vpc2_tgw_sub_1a.az

  tags = {
    Name = var.vpc2_tgw_sub_1a.name
  }
}

resource "aws_subnet" "vpc2_tgw_sub_1c" {
  vpc_id = aws_vpc.vpc2.id
  cidr_block = var.vpc2_tgw_sub_1c.cidr
  availability_zone = var.vpc2_tgw_sub_1c.az

  tags = {
    Name = var.vpc2_tgw_sub_1c.name
  }
}


##===============================
## Resource: Network ACL
## Ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl
## Required: vpc_id
##===============================

variable vpc2_nacl_name {}

resource "aws_network_acl" "vpc2_nacl" {
  vpc_id = aws_vpc.vpc2.id

  tags = {
    Name = var.vpc2_nacl_name
  }

  egress {
    protocol = "-1"
    rule_no  = 2000
    action   = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 0
    to_port = 0
  }

  ingress {
    protocol = "-1"
    rule_no = 1000
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 0
    to_port = 0
  }
}


##================================
## Resource: Route Table
## Ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
## Requeire: vpc_id
##================================

variable "vpc2_rtb_default_name" {}
variable "vpc2_rtb_tgw_name" {}

resource "aws_route_table" "vpc2_rtb_default" {
  vpc_id = aws_vpc.vpc2.id

  tags = {
    Name = var.vpc2_rtb_default_name
  }
}


resource "aws_route_table" "vpc2_rtb_tgw" {
  vpc_id = aws_vpc.vpc2.id

  tags = {
    Name = var.vpc2_rtb_tgw_name
  }
}

##===================================
## Resource: aws_route_table_association
## Ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
##===================================

resource "aws_route_table_association" "vpc2_rtb_pri_association_1a" {
  subnet_id = aws_subnet.vpc2_pri_sub_1a.id
  route_table_id = aws_route_table.vpc2_rtb_default.id
}

resource "aws_route_table_association" "vpc2_rtb_pri_association_1c" {
  subnet_id = aws_subnet.vpc2_pri_sub_1c.id
  route_table_id = aws_route_table.vpc2_rtb_default.id
}

resource "aws_route_table_association" "vpc2_rtb_dmzi_association_1a" {
  subnet_id = aws_subnet.vpc2_dmzi_sub_1a.id
  route_table_id = aws_route_table.vpc2_rtb_default.id
}

resource "aws_route_table_association" "vpc2_rtb_dmzi_association_1c" {
  subnet_id = aws_subnet.vpc2_dmzi_sub_1c.id
  route_table_id = aws_route_table.vpc2_rtb_default.id
}

resource "aws_route_table_association" "vpc2_rtb_dmze_association_1a" {
  subnet_id = aws_subnet.vpc2_dmze_sub_1a.id
  route_table_id = aws_route_table.vpc2_rtb_default.id
}

resource "aws_route_table_association" "vpc2_rtb_dmze_association_1c" {
  subnet_id = aws_subnet.vpc2_dmze_sub_1c.id
  route_table_id = aws_route_table.vpc2_rtb_default.id
}

resource "aws_route_table_association" "vpc2_rtb_tgw_association_1a" {
  subnet_id = aws_subnet.vpc2_tgw_sub_1a.id
  route_table_id = aws_route_table.vpc2_rtb_tgw.id
}

resource "aws_route_table_association" "vpc2_rtb_tgw_association_1c" {
  subnet_id = aws_subnet.vpc2_tgw_sub_1c.id
  route_table_id = aws_route_table.vpc2_rtb_tgw.id
}


