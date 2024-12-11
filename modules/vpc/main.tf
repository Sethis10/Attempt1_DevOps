#create vpc
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    name = "${var.project_name}-vpc"
  }
}

#create internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    name = "${var.project_name}-igw"
  }
}

#availability zones
data "aws_availability_zones" "available_zones" {}

#create public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = element(data.aws_availability_zones.available_zones.names, 0)
  map_public_ip_on_launch = true

  tags = {
    name = "${var.project_name}-public_subnet"
  }
}

#create route table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    name = "${var.project_name}-public-route-table"
  }
}

#association of public route table and subnet
resource "aws_route_table_association" "public_rt_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

#create private subnet
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_subnet_cidr
  availability_zone       = element(data.aws_availability_zones.available_zones.names, 1)
  map_public_ip_on_launch = false

  tags = {
    name = "${var.project_name}-private-subnet"
  }
}

## Now for private subnet we need nat gateway for internet connectivity