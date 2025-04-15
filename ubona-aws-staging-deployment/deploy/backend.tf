terraform {
  backend "s3" {
    bucket = "ubona-hyd-bcp-tfstate"
    key    = "backend/ubona-hyd-bcp.tfstate"
    region = "ap-south-2"
  }
}