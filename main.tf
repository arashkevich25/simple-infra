provider "aws" {
    region = var.region
    profile = var.project_short_name
}

terraform {
  required_version = ">=1.2.2"
  backend "s3" {
    bucket = "famterraform"
    key = ".../terraform.tfstate"
    region = "eu-north-1"
    encrypt = true
    profile = "fam"
  }
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.20.1"
    }
  }
}

resource "aws_vpc" "this" {
    cidr_block = var.vpc_cidr_block
    enable_dns_hostnames = true
    enable_dns_support = true
    tags = {
        terraform: "infra"
        stage: var.stage
        Name: "${var.project_short_name}_vpc"
    }
}
