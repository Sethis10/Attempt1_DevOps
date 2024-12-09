terraform {
  backend "s3" {
    bucket = "sagar-s3-attempt1"
    key = "backend/attempt1-terraform.tfstate"
    region = "us-east-1"
  }
}