resource "aws_instance" "node2" {
  ami = "${lookup(var.AMIS,"us-east-1")}"
  instance_type = "t2.large"
  key_name = "${aws_key_pair.admin-key.key_name}"
  vpc_security_group_ids = ["${aws_security_group.allow-all.id}"]
  subnet_id = "${aws_subnet.main-private-1.id}"

  private_ip = "10.0.4.12"

  tags {
    Name = "app"
  }

} 

resource "aws_route53_record" "node2" {
  zone_id = "${aws_route53_zone.lab.zone_id}"
  name    = "node2.lab.internal"
  type    = "A"
  ttl = "300"
  records = ["${aws_instance.node2.private_ip}"]
}
resource "aws_volume_attachment" "ebs_node2_sdb" {
  device_name = "/dev/sdb"
  volume_id   = "${aws_ebs_volume.node2_sdb.id}"
  instance_id = "${aws_instance.node2.id}"
}

resource "aws_volume_attachment" "ebs_node2_sdc" {
  device_name = "/dev/sdc"
  volume_id   = "${aws_ebs_volume.node2_sdc.id}"
  instance_id = "${aws_instance.node2.id}"
}

resource "aws_volume_attachment" "ebs_node2_sdd" {
  device_name = "/dev/sdd"
  volume_id   = "${aws_ebs_volume.node2_sdd.id}"
  instance_id = "${aws_instance.node2.id}"
}

