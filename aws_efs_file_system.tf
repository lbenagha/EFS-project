resource "aws_efs_file_system" "efs" {
  creation_token = "w_efs"
  depends_on     = [aws_security_group.sg1]
  tags = {
    Name = "Wordpress-EFS"
  }
}
