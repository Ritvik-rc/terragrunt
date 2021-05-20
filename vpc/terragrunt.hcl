terraform {
    source = "git::https://github.com/Ritvik-rc/terraform-code//vpc"
}
include {
    path = find_in_parent_folders("providers.hcl")
}
inputs = {
    vpc_cidr = "10.5.4.0/24"
    zone_a = {
        availability_zone = "ap-south-1a"
        cidr = "10.5.4.32/28"
    }
    zone_b = {
        availability_zone = "ap-south-1b"
        cidr = "10.5.4.0/27"
    }
    zone_c = {
        availability_zone = "ap-south-1c"
        cidr = "10.5.4.64/28"
    }
}
remote_state {
  backend = "s3"
  config = {
    bucket         = "tf-state-itt"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}