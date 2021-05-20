generate "provider" {
    path = "provider.tf"
    if_exists = "overwrite_terragrunt"
    contents = <<EOF
        terraform {
            required_providers{
                aws = {
                    source = "hashicorp/aws"
                    version = "~> 3.27"
                }
            }
        }
        provider "aws" {
            region = "ap-south-1"
            profile = "terra-admin"
        }
    EOF
}

generate "backend" {
    path = "backend.tf"
    if_exists = "overwrite_terragrunt"
    contents = <<EOF
        terraform {
            backend "s3" {}
        }
    EOF
}