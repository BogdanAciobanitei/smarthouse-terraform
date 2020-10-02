resource "aws_s3_bucket" "bucket" {
  bucket = "${var.environment}-${var.bucket_name}"
}
