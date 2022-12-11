##==================================
## Resource: IAM role
## Ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
##==================================

variable "ec2_role_name" {}

data "aws_iam_policy" "ssm_policy" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role" "ec2_role" {
  name = var.ec2_role_name
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

variable "ec2_policy_attach_name" {}

resource "aws_iam_policy_attachment" "ec2_policy_attach" {
  name = var.ec2_policy_attach_name
  roles = [aws_iam_role.ec2_role.name]
  policy_arn = data.aws_iam_policy.ssm_policy.arn
}


##==================================
## Resource: EC2 instance profile
## Ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile
##==================================

variable "ec2_instance_profile" {}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = var.ec2_instance_profile
  role = aws_iam_role.ec2_role.id
}


##==================================
## Resource: EC2 instance
## Ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance 
##==================================

variable "ec2_name" {}

data "aws_ssm_parameter" "amazonlinux_ami"{
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

resource "aws_instance" "ec2" {
  ami = data.aws_ssm_parameter.amazonlinux_ami.value
  instance_type = "t2.micro"
  subnet_id = aws_subnet.pri_sub_1a.id
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.id

  tags = {
    Name = var.ec2_name
  }
}

output "ec2" {
  value = aws_instance.ec2.id
}
