resource "aws_efs_mount_target" "mount_efs" {
  depends_on = [aws_efs_file_system.efs, aws_instance.web_ec2]
file_system_id = aws_efs_file_system.efs.id
  subnet_id      = aws_default_subnet.default_az1.id
}