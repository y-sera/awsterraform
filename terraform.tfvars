## vpc
vpc = {
 cidr = "192.168.0.0/25"
 name = "tf-vpc"
}

## public subnet
public_subnet_1a = {
 cidr = "192.168.0.0/27"
 name = "tf-pub-sub-1a" 
 az = "ap-northeast-1a"
}


## private subnet
private_subnet_1a = {
 cidr = "192.168.0.64/27"
 name = "tf-pri-sub-1a"
 az = "ap-northeast-1a"
}


