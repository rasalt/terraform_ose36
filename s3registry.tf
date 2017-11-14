resource "aws_s3_bucket" "Put name here" {
  bucket = "Put name here"
  acl    = "private"

  tags {
    Name        = "Put name here"
    Environment = "openshift"
  }
}
