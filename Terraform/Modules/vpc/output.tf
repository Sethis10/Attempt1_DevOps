output "vpc_id" {
  value = aws_vpc.my-vpc.id
}

output "pub_sub_1a" {
  value = aws_subnet.pub_sub_1a.id
}

output "pub_sub_2b" {
  value = aws_subnet.pub_sub_2b.id
}

output "pri_sub_3a" {
  value = aws_subnet.pri_sub_3a.id
}

output "pri_sub_4b" {
  value = aws_subnet.pri_sub_4b.id
}

output "igw" {
  value = aws_internet_gateway.my-igw.id
}