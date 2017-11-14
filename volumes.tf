resource "aws_ebs_volume" "master0_sdb" {
  availability_zone = "us-east-1a"
  size              = 10
}

resource "aws_ebs_volume" "node0_sdb" {
  availability_zone = "us-east-1a"
  size              = 10
}
resource "aws_ebs_volume" "node0_sdc" {
  availability_zone = "us-east-1a"
  size              = 20
}
resource "aws_ebs_volume" "node0_sdd" {
  availability_zone = "us-east-1a"
  size              = 20
}

resource "aws_ebs_volume" "node1_sdb" {
  availability_zone = "us-east-1a"
  size              = 10
}
resource "aws_ebs_volume" "node1_sdc" {
  availability_zone = "us-east-1a"
  size              = 20
}
resource "aws_ebs_volume" "node1_sdd" {
  availability_zone = "us-east-1a"
  size              = 20
}

resource "aws_ebs_volume" "node2_sdb" {
  availability_zone = "us-east-1a"
  size              = 10
}
resource "aws_ebs_volume" "node2_sdc" {
  availability_zone = "us-east-1a"
  size              = 20
}
resource "aws_ebs_volume" "node2_sdd" {
  availability_zone = "us-east-1a"
  size              = 20
}

resource "aws_ebs_volume" "infra_sdb" {
  availability_zone = "us-east-1a"
  size              = 10
}



