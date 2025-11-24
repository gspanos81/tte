terraform {
  required_version = "~> 1.0"
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
    random = {
        source = "hashicorp/random"
        version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-west-1"
  alias = "west_1_value"
  
}
provider "aws" {
  region = "us-west-2"
  alias = "west_2_value"
  
  
}
resource "aws_s3_bucket" "west_1_random_bucket_fff" {
  bucket = "my-random-bucket-33"
  provider = aws.west_1_value
  
  
}
resource "aws_s3_bucket" "west_2_random_bucket_fff" {
  bucket = "my-random-bucket-332"
  provider = aws.west_2_value
  
}