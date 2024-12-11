variable "region" {
  description = "name of the aws region"
  default = "us-east-1"
}

variable "project_name" {
  description = "name of the project"
}

variable "vpc_cidr" {}
variable "public_subnet_cidr" {}
variable "private_subnet_cidr" {}