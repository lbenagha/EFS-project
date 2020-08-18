resource "aws_s3_bucket" "bucket1" {
  bucket        = "task1-myimage"
  acl           = "public-read"
  force_destroy = true
}
