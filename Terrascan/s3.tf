# Create S3 
resource "aws_s3_bucket" "s3_bucket" {
  bucket = "terrascan-bucket-demo01"
}
resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.s3_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
