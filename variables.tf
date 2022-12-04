variable "region" {
    default = "eu-north-1"
}
variable "api_domain" {}
variable "base_domain" {}
variable "project_name" {}
variable "project_short_name" {}
variable "db_storage_type" {
    default = "gp2"
}
variable "db_allocated_storage" {
    default = 20
}
variable "db_instance_class" {
    default = "db.t3.micro"
}
variable "vpc_cidr_block" {}
variable "subnet_cidr_block" {}
variable "subnet_cidr_block_1" {}
variable "subnet_cidr_block_2" {}
variable "subnet_cidr_public_block_1" {}
variable "subnet_cidr_public_block" {}
variable "stage" {}
variable "azs" {}
variable "db_name" {}
variable "db_user" {}
variable "db_password" {}
