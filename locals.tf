locals {
  s3_origin_id = "S3-task1-myimage"
}
resource "aws_cloudfront_distribution" "s3_distribution" { //Origin Settings
depends_on = [aws_s3_bucket.bucket1]
  origin {
    domain_name = "${aws_s3_bucket.bucket1.bucket_domain_name}"
    origin_id   = "${local.s3_origin_id}"
    }  
     enabled         = true
     is_ipv6_enabled = true
   restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${local.s3_origin_id}"

    forwarded_values {
      query_string = false
      cookies{ 
      forward = "none"
      }
    }
    viewer_protocol_policy = "allow-all"
  }
    viewer_certificate {
    cloudfront_default_certificate = true

    }
  }