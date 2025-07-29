provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket         = "puneethys-tf-state-1123581321345589"
    key            = "global/s3/vpc/terraform.tfstate"
    dynamodb_table = "terraform-state"
    region         = "us-east-1"
    encrypt        = true
  }
}
