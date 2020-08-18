provider "aws" {
  profile = var.profile
  region  = var.region
}
variable "region" { default = "us-east-1" }
variable "profile" { default = "default" }
variable "availability_zone" { default = "us-east-1a" }
variable "key_name" { default = "kkey" }
