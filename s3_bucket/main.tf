resource "aws_s3_bucket" "ubisoft163_bucket" {
  bucket = "${var.bucket_name}"
  region = "${var.region}"
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = "${var.bucket_name}"

  lambda_function {
    lambda_function_arn = "${var.bucket_notification_lambda_arn}"
    events              = ["s3:ObjectRemoved:Delete"]
  }
}