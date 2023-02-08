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
  enable_dns_support = true

  tags = {
    Name = var.vpc.name
  }
}

output "vpc" {
  value = aws_vpc.vpc.cidr_block
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

variable "pub_sub_1c" {
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
variable "pri_sub_1c" {
  type = object({
    cidr = string
    name = string
    az = string
  })
}
variable "tgw_sub_1a" {
  type = object({
    cidr = string
    name = string
    az = string
  })
}
variable "tgw_sub_1c" {
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

resource "aws_subnet" "pub_sub_1c" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.pub_sub_1c.cidr
  availability_zone = var.pub_sub_1c.az

  tags = {
    Name = var.pub_sub_1c.name
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
resource "aws_subnet" "pri_sub_1c" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.pri_sub_1c.cidr
  availability_zone = var.pri_sub_1c.az

  tags = {
    Name = var.pri_sub_1c.name
  }
}
resource "aws_subnet" "tgw_sub_1a" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.tgw_sub_1a.cidr
  availability_zone = var.tgw_sub_1a.az

  tags = {
    Name = var.tgw_sub_1a.name
  }
}
resource "aws_subnet" "tgw_sub_1c" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.tgw_sub_1c.cidr
  availability_zone = var.tgw_sub_1c.az

  tags = {
    Name = var.tgw_sub_1c.name
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


##===============================
## Resource: Network ACL
## Ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl
## Required: vpc_id
##===============================

variable nacl_name {}

resource "aws_network_acl" "nacl" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.nacl_name
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
## Resource: Elastic IP
## Ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip
##================================
variable eip_name {}

resource "aws_eip" "eip" {
  vpc = true
}


##================================
## Resource: NAT Gateway
## Ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway
## Requeire: subnet_id
##================================

variable nat_name {}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip.id
  subnet_id = aws_subnet.pub_sub_1a.id

  tags = {
    Name = var.nat_name
  }
}


##================================
## Resource: Route Table
## Ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
## Requeire: vpc_id
##================================

variable "rtb_pub_name" {}
variable "rtb_pri_name" {}
variable "rtb_tgw_name" {}

resource "aws_route_table" "rtb_pub" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.rtb_pub_name
  }
}

resource "aws_route_table" "rtb_pri" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.rtb_pri_name
  }
}

resource "aws_route_table" "rtb_tgw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.rtb_tgw_name
  }
}

##==================================
## Resource: Route
## Ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
##==================================

resource "aws_route" "route_pub" {
  route_table_id = aws_route_table.rtb_pub.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id
}

resource "aws_route" "route_pri" {
  route_table_id = aws_route_table.rtb_pri.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat.id
}

resource "aws_route" "route_tgw" {
  route_table_id = aws_route_table.rtb_tgw.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat.id
}

##===================================
## Resource: aws_route_table_association
## Ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
##===================================

resource "aws_route_table_association" "rtb_pub_association_1a" {
  subnet_id = aws_subnet.pub_sub_1a.id
  route_table_id = aws_route_table.rtb_pub.id
}

resource "aws_route_table_association" "rtb_pub_association_1c" {
  subnet_id = aws_subnet.pub_sub_1c.id
  route_table_id = aws_route_table.rtb_pub.id
}

resource "aws_route_table_association" "rtb_pri_association_1a" {
  subnet_id = aws_subnet.pri_sub_1a.id
  route_table_id = aws_route_table.rtb_pri.id
}

resource "aws_route_table_association" "rtb_pri_association_1c" {
  subnet_id = aws_subnet.pri_sub_1c.id
  route_table_id = aws_route_table.rtb_pri.id
}

resource "aws_route_table_association" "rtb_tgw_association_1a" {
  subnet_id = aws_subnet.tgw_sub_1a.id
  route_table_id = aws_route_table.rtb_tgw.id
}

resource "aws_route_table_association" "rtb_tgw_association_1c" {
  subnet_id = aws_subnet.tgw_sub_1c.id
  route_table_id = aws_route_table.rtb_tgw.id
}

