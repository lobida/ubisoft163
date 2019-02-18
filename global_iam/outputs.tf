output "lambda_iam_arn" {
  value = "${aws_iam_role.lambda_iam.arn}"
}