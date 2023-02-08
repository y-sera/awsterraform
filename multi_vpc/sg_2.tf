##==================================
## Resource: Security Group
## Ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
##==================================

variable "vpc2_sg_ec2_name" {}

resource "aws_security_group" "vpc2_sg_ec2" {
  name = var.vpc2_sg_ec2_name
  description = "Managed by Terraform. for ec2."
  vpc_id = aws_vpc.vpc2.id
}


##==================================
## Resource: Security Group rule
## Ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule
##==================================

resource "aws_security_group_rule" "vpc2_sg_rule_ingress_ec2" {
  type = "ingress"
  from_port = 80 
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["192.168.0.0/22"]
  security_group_id = aws_security_group.vpc2_sg_ec2.id
}

resource "aws_security_group_rule" "vpc2_sg_rule_egress_ec2" {
  type = "egress"
  from_port = "-1"
  to_port = "-1"
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.vpc2_sg_ec2.id
}


##=================================
## Resource: Default Security Group
## Ref:
##=================================

resource "aws_default_security_group" "vpc2_default_sg" {
  vpc_id = aws_vpc.vpc2.id
}
