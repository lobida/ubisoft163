provider "aws" {
  region = "${var.region}"
}

module "s3_bucket" {
  source = "./s3_bucket"
  region = "${var.region}"
  bucket_name = "${var.bucket_name}"
}
