terraform {
  backend "s3" {
    bucket         = "puneethys-tf-state-1123581321345589"
    key            = "global/s3/terraform.tfstate"
    dynamodb_table = "terraform-state"
    region         = "us-east-1"
    encrypt        = true
  }

  required_providers {
    aws = ">= 5.0, < 6.0"
  }
}

provider "aws" {
  region = var.region
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "puneethys-tf-state-1123581321345589"
    key    = "global/vpc/terraform.tfstate"
    region = "us-east-1"
  }
}

module "talk-booking-service" {
  source = "../../modules/talk-booking-service"

  vpc_id                          = data.terraform_remote_state.vpc.outputs.vpc_id
  ecs_security_group_id           = data.terraform_remote_state.vpc.outputs.ecs_security_group_id
  load_balancer_security_group_id = data.terraform_remote_state.vpc.outputs.load_balancer_security_group_id
  public_subnet_1_id              = data.terraform_remote_state.vpc.outputs.public_subnet_1_id
  public_subnet_2_id              = data.terraform_remote_state.vpc.outputs.public_subnet_2_id
  private_subnet_1_id             = data.terraform_remote_state.vpc.outputs.private_subnet_1_id
  private_subnet_2_id             = data.terraform_remote_state.vpc.outputs.private_subnet_2_id
  log_retention_in_days           = 30
  region                          = var.region
  app_count                       = 1
  environment_name                = "talk-booking-dev"
  app_environment                 = "development"
}
