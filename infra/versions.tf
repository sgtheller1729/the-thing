terraform {
  required_version = "~> 1.9.8"
  backend "s3" {
    bucket         = "intern-iot-poc-tf-backend"
    key            = "terraform.tfstate"
    region         = "ap-northeast-1"
    dynamodb_table = "InternIoTPoCTerraformLocks"
  }
}
