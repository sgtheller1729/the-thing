terraform {
  required_version = "~> 1.9.8"
  backend "s3" {
    bucket         = "heller-poc-s3-bucket"
    key            = "terraform.tfstate"
    region         = "ap-northeast-1"
    dynamodb_table = "SimAppHellerPoCTerraformLocks"
  }
}
