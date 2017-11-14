resource "aws_efs_file_system" "iefs_ose36" {
  creation_token = "ose36"

  tags {
    Name = "aws_efs_ose36"
  }
}
