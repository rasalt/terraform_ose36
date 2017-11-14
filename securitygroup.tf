resource "aws_security_group" "allow-ssh" {
  vpc_id = "${aws_vpc.main.id}"
  name = "allow-ssh"
  description = "allows ssh for an ingress traffic"
  egress {
   from_port = 0
   to_port = 0
   protocol = "-1"
   cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
   from_port = 22 
   to_port = 22 
   protocol = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
   Name = "allow-ssh"
  }
}

resource "aws_security_group" "allow-all" {
  vpc_id = "${aws_vpc.main.id}"
  name = "allow-all"
  description = "allows all ingress/egress traffic traffic"
  egress {
   from_port = 0
   to_port = 0
   protocol = "-1"
   cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
   from_port = 0 
   to_port = 0 
   protocol = "-1"
   cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
   Name = "allow-all"
  }
}
