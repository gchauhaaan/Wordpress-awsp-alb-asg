resource "aws_s3_bucket" "mysql-wpdb-bucket" {
  bucket = "my-tf-test-bucket"
  acl    = "private"

  tags = {
    Name        = "bucket-name"
  }
}
