# create vpc
resource "aws_vpc" "my-vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true

    tags = {
      Name = "${var.project_name}-vpc"
    }
}

# create internet gateway attach it to vpc
resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my-vpc.id

    tags = {
      Name = "${var.project_name}-igw"
    }
}

# availability zones
data "aws_avaibility_zones" "available_zones" {
    state = "available"
}

# create public subnets pub-sub-1a
resource "aws_subnet" "pub_sub_1a" {
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = var.pub_sub_1a_cidr
  map_public_ip_on_launch = true
  availability_zone = data.aws_avaibility_zones.available.available_zones[0]
}