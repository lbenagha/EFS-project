resource "null_resource" "newlocal" {
  depends_on = [
    aws_efs_mount_target.mount_efs,
    aws_instance.web_ec2,
  ]
connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = tls_private_key.key.private_key_pem
    host        = aws_instance.web_ec2.public_ip
  }
provisioner "remote-exec" {
    inline = [
      "sudo chmod ugo+rw /etc/fstab",
      "sudo echo '${aws_efs_file_system.efs.id}:/ /var/www/html efs tls,_netdev' >> /etc/fstab",
      "sudo mount -a -t efs,nfs4 defaults",
      "sudo rm -rf /var/www/html/*",
      "sudo git clone https://github.com/Vishnukvsvk/LW-TASK1.git /var/www/html",
]
  }
}
resource "null_resource" "git_download" {
  provisioner "local-exec" {
    command = "git clone https://github.com/Vishnukvsvk/LW-TASK1.git Folder1"
  }
  
provisioner "local-exec" {
    when    = destroy
    command = "rmdir Folder1 /s /q" 
  }
}
resource "aws_s3_bucket_object" "image_upload" {
  key        = "image1.png"
  bucket     = aws_s3_bucket.bucket1.bucket
  source     = "Folder1/task1image.png"
  acl        = "public-read"
  content_type = "image/png"
  depends_on   = [aws_s3_bucket.bucket1, null_resource.git_download]
}