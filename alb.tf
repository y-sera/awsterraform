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
