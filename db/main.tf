resource "aws_dynamodb_table" "bucket_ops" {
  name           = "BucketOperations"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "object_name"
  range_key      = "deleted_at"

  attribute {
    name = "object_name"
    type = "S"
  }

  attribute {
    name = "deleted_at"
    type = "S"
  }
}