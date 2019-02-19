output "bucket_notification_lambda_arn" {
    value = "${aws_lambda_function.bucket_notification_lambda.arn}"
}
