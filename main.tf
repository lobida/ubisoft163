provider "aws" {
  region = "${var.region}"
}

module "global_iam" {
  source = "./global_iam"
  db_arn = "${module.db.bucket_ops_arn}"
}
module "s3_bucket" {
  source = "./s3_bucket"
  region = "${var.region}"
  bucket_name = "${var.bucket_name}"
  bucket_notification_lambda_arn = "${module.lambda_functions.bucket_notification_lambda_arn}"
}
module "db" {
  source = "./db"
  table_name = "${var.table_name}"
}
module "lambda_functions" {
  source = "./lambda_functions"
  lambda_role = "${module.global_iam.lambda_iam_arn}"
  db_table = "${module.db.bucket_ops_name}"
}
