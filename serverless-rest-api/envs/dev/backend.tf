terraform {
  backend "s3" {
    bucket       = "your-terraform-state-bucket"
    key          = "scalable-web/dev/terraform.tfstate"
    region       = "eu-north-1"
    encrypt      = true
    use_lockfile = true
  }
}