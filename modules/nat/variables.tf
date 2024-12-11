variable "vpc_id" {
  description = "The VPC ID"
  type        = string
}

variable "igw_id" {
  description = "The Internet Gateway ID"
  type        = string
}

variable "public_subnet_id" {
  description = "The Public Subnet ID"
  type        = string
}

variable "private_subnet_id" {
  description = "The Private Subnet ID"
  type        = string
}