output "bucket_ops_arn" {
  value = "${aws_dynamodb_table.bucket_ops.arn}"
}
output "bucket_ops_name" {
  value = "${aws_dynamodb_table.bucket_ops.id}"
}

