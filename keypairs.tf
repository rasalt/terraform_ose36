resource "aws_key_pair" "admin-key" {
  key_name   = "admin-key"
  public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}


