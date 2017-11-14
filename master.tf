resource "aws_instance" "master" {
  ami = "${lookup(var.AMIS,"us-east-1")}"
  instance_type = "t2.xlarge"
  key_name = "${aws_key_pair.admin-key.key_name}"
  vpc_security_group_ids = ["${aws_security_group.allow-all.id}"]
  subnet_id = "${aws_subnet.main-public-1.id}"

  private_ip = "10.0.1.20"
  tags {
    Name = "master"
  }

  provisioner "file" {
   source = "script.sh"
   destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
   inline = [
     "chmod a+x /tmp/script.sh",
     "sudo /tmp/script.sh"
   ]
  }

  provisioner "local-exec" {
     command = "echo ${aws_instance.master.private_ip} >> private_ips.txt"
  }

  connection {
   user = "${var.INSTANCE_USERNAME}"
   private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
  }
} 

output "master_ip" {
  value = "${aws_instance.master.public_ip}"
}

resource "aws_route53_record" "master" {
  zone_id = "${aws_route53_zone.lab.zone_id}"
  name    = "master.lab.internal"
  type    = "A"
  ttl = "300"
  records = ["${aws_instance.master.private_ip}"]
}

resource "aws_volume_attachment" "ebs_master0_sdb" {
  device_name = "/dev/sdb"
  volume_id   = "${aws_ebs_volume.master0_sdb.id}"
  instance_id = "${aws_instance.master.id}"
}

