##==================================
## Resource: IAM role
## Ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
##==================================

variable "vpc2_ec2_role_name" {}


resource "aws_iam_role" "vpc2_ec2_role" {
  name = var.vpc2_ec2_role_name
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
      "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
     }
   ]
}
EOF
}


##==================================
## Resource: IAM Policy attachment
## Ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment
##==================================

resource "aws_iam_role_policy_attachment" "vpc2_ec2_role_policy_attach" {
  role = aws_iam_role.vpc2_ec2_role.name
  policy_arn = data.aws_iam_policy.ssm_policy.arn
}


##==================================
## Resource: EC2 instance profile
## Ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile
##==================================

variable "vpc2_ec2_instance_profile" {}

resource "aws_iam_instance_profile" "vpc2_ec2_instance_profile" {
  name = var.vpc2_ec2_instance_profile
  role = aws_iam_role.ec2_role.id
}

##==================================
## Resource: EC2 instance
## Ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance 
##==================================

variable "vpc2_ec2_name" {}

resource "aws_instance" "vpc2_ec2" {
  ami = data.aws_ssm_parameter.amazonlinux_ami.value
  instance_type = "t2.micro"
  subnet_id = aws_subnet.vpc2_pri_sub_1a.id
  iam_instance_profile = aws_iam_instance_profile.vpc2_ec2_instance_profile.id
  vpc_security_group_ids = [aws_security_group.vpc2_sg_ec2.id]

  tags = {
    Name = var.vpc2_ec2_name
  }
}


output "vpc2_ec2" {
  value = aws_instance.vpc2_ec2.id
}
output "vpc2_ec2_ip" {
  value = aws_instance.vpc2_ec2.private_ip
}
