resource "aws_instance" "infra" {
  ami = "${lookup(var.AMIS,"us-east-1")}"
  instance_type = "t2.xlarge"
  key_name = "${aws_key_pair.admin-key.key_name}"
  vpc_security_group_ids = ["${aws_security_group.allow-all.id}"]
  subnet_id = "${aws_subnet.main-public-1.id}"

  private_ip = "10.0.1.30"

  provisioner "file" {
   source = "script.sh"
   destination = "/tmp/script.sh"
  }
  tags {
    Name = "infra"
  }

  provisioner "remote-exec" {
   inline = [
     "chmod a+x /tmp/script.sh",
     "sudo /tmp/script.sh"
   ]
  }

  provisioner "local-exec" {
     command = "echo ${aws_instance.infra.private_ip} >> private_ips.txt"
  }

  connection {
   user = "${var.INSTANCE_USERNAME}"
   private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
  }
} 

output "infra_ip" {
  value = "${aws_instance.infra.public_ip}"
}

resource "aws_route53_record" "infra" {
  zone_id = "${aws_route53_zone.lab.zone_id}"
  name    = "infra.lab.internal"
  type    = "A"
  ttl = "300"
  records = ["${aws_instance.infra.private_ip}"]
}


data "aws_route53_zone" "<domainname>" {
  name = "<domainname>.org."
}

resource "aws_route53_record" "wild_<domain>" {
  zone_id = "${data.aws_route53_zone.<domainname>.zone_id}"
  name    = "*.cloudapps.<domainname>.org."
  type    = "A"
  ttl = "300"
  records = ["${aws_instance.infra.public_ip}"]
}

resource "aws_volume_attachment" "ebs_infra_sdb" {
  device_name = "/dev/sdb"
  volume_id   = "${aws_ebs_volume.infra_sdb.id}"
  instance_id = "${aws_instance.infra.id}"
}
