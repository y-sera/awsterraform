##==================================
## Resource: Security Group
## Ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
##==================================

variable "sg_alb_name" {}
variable "sg_ec2_name" {}

resource "aws_security_group" "sg_alb" {
  name = var.sg_alb_name
  description = "Managed by Terraform. for alb."
  vpc_id = aws_vpc.vpc.id
}

resource "aws_security_group" "sg_ec2" {
  name = var.sg_ec2_name
  description = "Managed by Terraform. for ec2."
  vpc_id = aws_vpc.vpc.id
}


##==================================
## Resource: Security Group rule
## Ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule
##==================================

resource "aws_security_group_rule" "sg_rule_alb_ingress" {
  type = "ingress"
  from_port = 0
  to_port = 80
  protocol = "tcp"
  cidr_blocks = [aws_vpc.vpc.cidr_block]
  security_group_id = aws_security_group.sg_alb.id
}

resource "aws_security_group_rule" "sg_rule_egress_alb" {
  type = "egress"
  from_port = 0 
  to_port = 0
  protocol = "tcp"
  cidr_blocks = [aws_vpc.vpc.cidr_block]
  security_group_id = aws_security_group.sg_alb.id
}

resource "aws_security_group_rule" "sg_rule_ingress_ec2" {
  type = "ingress"
  from_port = 80 
  to_port = 80
  protocol = "tcp"
  source_security_group_id = aws_security_group.sg_alb.id
  security_group_id = aws_security_group.sg_ec2.id
}

resource "aws_security_group_rule" "sg_rule_egress_ec2" {
  type = "egress"
  from_port = 0 
  to_port = 0
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_ec2.id
}


