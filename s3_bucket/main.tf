resource "aws_s3_bucket" "ubisoft163_bucket" {
  bucket = "${var.bucket_name}"
  region = "${var.region}"
  acl    = "private"
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = "${var.bucket_name}"

  lambda_function {
    lambda_function_arn = "${var.bucket_notification_lambda_arn}"
    events              = ["s3:ObjectCreated:*"]
  }
}