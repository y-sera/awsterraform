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


##=========================
## alb.tf
##=========================

# ALB
alb_name = "tf-alb"

# ALB Target Group
alb_target_name = "alb-target"

# ALB listener
alb_listener_name = "tf-alb-listener"

