variable "region" {
  description = "region for aws"
  default = "us-east-1"
}

variable "project_name" {
  description = "name of your project"
}

variable "vpc_cidr" {}
variable "pub_sub_1a_cidr" {}
variable "pub_sub_2b_cidr" {}
variable "pri_sub_3a_cidr" {}
variable "pri_sub_4b_cidr" {}