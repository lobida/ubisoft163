data "archive_file" "lambda_zip" {
    type          = "zip"
    source_file   = "echo.py"
    output_path   = "lambda_function.zip"
}
resource "aws_lambda_function" "bucket_notification_lambda" {
  filename         = "lambda_function"
  function_name    = "bucket_notification_lambda"
  role             = "${var.lambda_role}"
  handler          = "echo.bucket_notification"
  source_code_hash = "${base64sha256(file("lambda_function.zip"))}"
  runtime          = "python3.6"
}

output "bucket_notification_lambda_arn" {
    value = "${aws_lambda_function.bucket_notification_lambda.arn}"
}