data "archive_file" "lambda_zip" {
    type          = "zip"
    source_file   = "echo.py"
    output_path   = "lambda_function.zip"
}
resource "aws_lambda_function" "bucket_notification_lambda" {
  filename         = "lambda_function.zip"
  function_name    = "bucket_notification_lambda"
  role             = "${var.lambda_role}"
  handler          = "echo.bucket_notification"
  source_code_hash = "${base64sha256(file("lambda_function.zip"))}"
  runtime          = "python3.7"
  environment {
    variables = {
      DB_TABLE = "${var.db_table}"
    }
  }
}

resource "aws_lambda_permission" "allow_bucket_notification" {
  statement_id  = "AllowExecutionFromS3"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.bucket_notification_lambda.function_name}"
  principal     = "s3.amazonaws.com"
}