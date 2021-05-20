terraform {
    source = "git::https://github.com/Ritvik-rc/terraform-code//ec2"
}
include {
    path = find_in_parent_folders("providers.hcl")
}
inputs = {
    image_id = "ami-0bcf5425cdc1d8a85"
    instance_type  = "t2.micro"
    no_of_instance = 3
    vpc_id = dependency.vpc.outputs.vpc_id
    pub1_sub_id = dependency.vpc.outputs.pub1_sub_id
    pub2_sub_id = dependency.vpc.outputs.pub2_sub_id
    pvt_sub_id = dependency.vpc.outputs.pvt_sub_id
}

dependency "vpc" {
    config_path = "../vpc"
    mock_outputs = {
        vpc_id = "temporary-dummy-id"
        pub1_sub_id = "temporary-dummy-id"
        pub2_sub_id = "temporary-dummy-id"
        pvt_sub_id = "temporary-dummy-id"
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