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

    tags = {
        name = "pub_sub_1a"
    }
}

# create public subnet pub_sub_2b
resource "aws_subnet" "pub_sub_2b" {
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = var.pub_sub_2b_cidr
  map_public_ip_on_launch = true
  availability_zone = data.aws_avaibility_zones.availability_zone[1]

    tags = {
      name = "pub_sub_2b"
    }
}

# create route table

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my-vpc.id

  route {
  cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.my-igw.vpc_id
  }

    tags = {
      Name = "Public-rt"
    }

}

# Associate public subnet to public route table 1a

resource "aws_route_table_association" "pub_sub_1a_rt_association" {
  subnet_id = aws_subnet.pub_sub_1a.id
  route_table_id = aws_route_table.public_route_table.id
}

# Associate public subnet to public route table 2a

resource "aws_route_table_association" "pub_sub_2b_rt_association" {
  subnet_id = aws_subnet.pub_sub_2b.id
  route_table_id = aws_route_table.public_route_table.id
}

# create private subnet pri_sub_3a
resource "aws_subnet" "pri_sub_3a" {
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = var.pri_sub_3a_cidr
  map_public_ip_on_launch = false
  availability_zone = data.aws_avaibility_zones.availability_zone[0]

    tags = {
        name = "pri_sub_3a "
    }
}

# create public subnet pri_sub_4b
resource "aws_subnet" "pri_sub_4b" {
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = var.pri_sub_4b_cidr
  map_public_ip_on_launch = false
  availability_zone = data.aws_avaibility_zones.availability_zone[1]

  tags = {
    name = "pri_sub_4b"
  }
}