terraform {
  required_version = ">= 1.7.0, < 2.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
  # alias  = "west_2_value"

}
provider "aws" {
  region = "eu-west-2"
   alias  = "west2"

}