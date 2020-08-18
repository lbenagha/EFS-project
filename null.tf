resource "null_resource" "update_link" {
    connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = tls_private_key.key.private_key_pem
    host        = aws_instance.web_ec2.public_ip
    port        = 22
  }
  provisioner "remote-exec" {
    inline = [
        "sudo chmod 777 /var/www/html -R",
        "sudo echo \"<img src='http://${aws_cloudfront_distribution.s3_distribution.domain_name}/${aws_s3_bucket_object.image_upload.key}'>\" >> /var/www/html/index.html",
    ]
  }
  depends_on = [aws_cloudfront_distribution.s3_distribution]
}
