terraform {
  backend "s3" {
    bucket = "ubona-prepod-irctc-tfstate"
    key    = "backend/ubona-prepod-irctc.tfstate"
    region = "ap-south-1"
  }
}