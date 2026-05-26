terraform {
  backend "s3" {
    bucket         = "atharva-terraform-state-2026"
    key            = "dev/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}