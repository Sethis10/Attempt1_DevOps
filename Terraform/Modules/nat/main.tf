# create nat gateway in public subnet pub_sub_1a
resource "aws_nat_gateway" "nat-gw-a" {
  subnet_id = aws_subnet.pub_sub_1a.id
    tags = {
      name = "nat-gw-a"
    }

    depends_on = [var.igw_id]
}

# create nat gateway in public subnet pub_sub_2b
resource "aws_nat_gateway" "nat-gw-b" {
  subnet_id = aws_subnet.pub_sub_2b.id
    tags = {
      name = "nat=gw-b"
    }

    depends_on = [var.igw_id]
}

# create route table for private subnets 3a
resource "aws_route_table" "private_route_table" {
    vpc_id = aws_vpc.vpc_id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat-gw-a.id
    }
    tags = {
      name = "pri_rt_a"
    }
  
}

# associate route table to use private subnets 3a
resource "aws_route_table_association" "pri_sub_3a_rt_association" {
    subnet_id = aws_subnet.pri_sub_3a.id
    route_table_id = aws_route_table.private_route_table.id
}

# associate route table to use private subnets 4b
resource "aws_route_table_association" "pri_sub_4b_rt_association" {
    subnet_id = aws_subnet.pri_sub_4b.id
    route_table_id = aws_route_table.private_route_table.id
}