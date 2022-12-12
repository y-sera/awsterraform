## vpc
vpc = {
 cidr = "192.168.0.0/25"
 name = "tf-vpc"
}

## public subnet
pub_sub_1a = {
 cidr = "192.168.0.0/27"
 name = "tf-pub-sub-1a" 
 az = "ap-northeast-1a"
}

pub_sub_1c = {
 cidr = "192.168.0.32/27"
 name = "tf-pub-sub-1c"
 az = "ap-northeast-1c"
}

## private subnet
pri_sub_1a = {
 cidr = "192.168.0.64/27"
 name = "tf-pri-sub-1a"
 az = "ap-northeast-1a"
}

## Internet Gateway
igw_name = "tf-igw"
  

## Network ACL
nacl_name = "tf-nacl"


## Elastic IP (for NAT Gateway)
eip_name = "tf-eip"

## NAT Gateway
nat_name = "tf-nat"

## Route Table
rtb_pub_name = "rtb_pub"
rtb_pri_name = "rtb_pri"


##=========================
## alb.tf
##=========================

# ALB
alb_name = "tf-alb"

# ALB Target Group
alb_target_name = "alb-target"

# ALB listener
alb_listener_name = "tf-alb-listener"


##========================
## ec2.tf
##========================

# ec2 role
ec2_role_name = "tf-ec2-ssm-role"

# ec2 policy attachment to role
ec2_policy_attach_name = "tf-policy-attach"

# ec2 instance profile
ec2_instance_profile = "tf-ec2-instance-profile"

# ec2 instance 
ec2_name = "tf-ec2"


##=======================
## sg.tf
##=======================

# security group for alb
sg_alb_name = "sg_alb"

# security group for ec2
sg_ec2_name = "sg_ec2"


