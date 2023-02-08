## vpc
vpc = {
 cidr = "192.168.0.0/24"
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

pri_sub_1c = {
 cidr = "192.168.0.96/27"
 name = "tf-pri-sub-1c"
 az = "ap-northeast-1c"
}

## transit gateway subnet
tgw_sub_1a = {
 cidr = "192.168.0.128/28"
 name = "tf-tgw-sub-1a"
 az = "ap-northeast-1a"
}

tgw_sub_1c = {
 cidr = "192.168.0.144/28"
 name = "tf-tgw-sub-1c"
 az = "ap-northeast-1c"
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
rtb_pub_name = "tf-rtb_pub"
rtb_pri_name = "tf-rtb_pri"
rtb_tgw_name = "tf-rtb_tgw"


##========================
## ec2.tf
##========================

# ec2 role
ec2_role_name = "tf-ec2-role"

# ec2 instance profile
ec2_instance_profile = "tf-ec2-instance-profile"

# ec2 instance 
ec2_name = "tf-ec2"


##=======================
## sg.tf
##=======================

# security group for ec2
sg_ec2_name = "sg_ec2"

#=====================================
#=====================================

#=======================
# vpc2.tf
#=======================
## vpc2
vpc2 = {
 cidr = "192.168.1.0/24"
 name = "tf-vpc2"
}

## private subnet
vpc2_pri_sub_1a = {
 cidr = "192.168.1.0/27"
 name = "tf-vpc2-pri-sub-1a" 
 az = "ap-northeast-1a"
}

vpc2_pri_sub_1c = {
 cidr = "192.168.1.32/27"
 name = "tf-vpc2-pri-sub-1c"
 az = "ap-northeast-1c"
}

## dmzi subnet
vpc2_dmzi_sub_1a = {
 cidr = "192.168.1.64/27"
 name = "tf-vpc2-dmzi-sub-1a"
 az = "ap-northeast-1a"
}

vpc2_dmzi_sub_1c = {
 cidr = "192.168.1.96/27"
 name = "tf-vpc2-dmzi-sub-1c"
 az = "ap-northeast-1c"
}

## dmze subnet
vpc2_dmze_sub_1a = {
 cidr = "192.168.1.128/27"
 name = "tf-vpc2-dmze-sub-1a"
 az = "ap-northeast-1a"
}

vpc2_dmze_sub_1c = {
 cidr = "192.168.1.160/27"
 name = "tf-vpc2-dmze-sub-1c"
 az = "ap-northeast-1c"
}

## transit gateway subnet
vpc2_tgw_sub_1a = {
 cidr = "192.168.1.192/28"
 name = "tf-vpc2-tgw-sub-1a"
 az = "ap-northeast-1a"
}

vpc2_tgw_sub_1c = {
 cidr = "192.168.1.208/28"
 name = "tf-vpc2-tgw-sub-1c"
 az = "ap-northeast-1c"
}

## Network ACL
vpc2_nacl_name = "tf-vpc2-nacl"

## Route Table
vpc2_rtb_default_name = "tf-vpc2_rtb_default"
vpc2_rtb_tgw_name = "tf-vpc2_rtb_tgw"

##========================
## ec2_2.tf
##========================

# ec2 role
vpc2_ec2_role_name = "tf-vpc2-ec2-ssm-role"

# ec2 instance 
vpc2_ec2_name = "tf-vpc2-ec2"

# ec2 instance profile
vpc2_ec2_instance_profile = "tf-vpc2-ec2-instance-profile"


##=======================
## sg.tf
##=======================

# security group for ec2
vpc2_sg_ec2_name = "vpc2_sg_ec2"


