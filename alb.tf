##===============================
## Resource: ELB(ALB)
## Ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb
##===============================
variable "alb_name" {}

resource "aws_lb" "alb" {
  name = var.alb_name
  internal = false
  load_balancer_type = "application"
#  security_groups = 

  subnet_mapping {
    subnet_id = aws_subnet.pub_sub_1a.id
  }

  subnet_mapping {
    subnet_id = aws_subnet.pub_sub_1c.id
  }

  tags = {
    Name = var.alb_name
  }
}



##================================
## Resource: ELB Target Group
## Ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group
##================================
variable "alb_target_name" {}

resource "aws_lb_target_group" "alb_target" {
  name = var.alb_target_name
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.vpc.id
}


##================================
## Resource: ELB listener
## Ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener
## Required: default_action, load_balancer_arn
##================================

variable "alb_listener_name" {}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  protocol = "HTTP"
  port = "80"

  default_action {
     target_group_arn = aws_lb_target_group.alb_target.arn
     type = "forward"
  }

  tags = {
    Name = var.alb_listener_name
  }
}

