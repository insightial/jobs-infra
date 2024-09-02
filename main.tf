terraform {
  backend "s3" {
    bucket = "jobs-infra-terraform-state"
    key = "terraform.tfstate"
    region = "us-east-1"
  }
}

module "s3" {
  source = "./modules/s3"
}
