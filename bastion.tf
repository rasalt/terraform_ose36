resource "aws_instance" "bastion" {
  ami = "${lookup(var.AMIS,"us-east-1")}"
  ami = "ami-c998b6b2"
  instance_type = "t2.xlarge"
  key_name = "${aws_key_pair.admin-key.key_name}"
  vpc_security_group_ids = ["${aws_security_group.allow-ssh.id}"]
  subnet_id = "${aws_subnet.main-public-1.id}"

  private_ip = "10.0.1.10"
  tags {
    Name = "bastion"
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
     command = "echo ${aws_instance.bastion.private_ip} >> private_ips.txt"
  }

  connection {
   user = "${var.INSTANCE_USERNAME}"
   private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
  }
} 

output "bastion_ip" {
  value = "${aws_instance.bastion.public_ip}"
}

resource "aws_route53_record" "bastion" {
  zone_id = "${aws_route53_zone.lab.zone_id}"
  name    = "bastion.lab.internal"
  type    = "A"
  ttl = "300"
  records = ["${aws_instance.bastion.private_ip}"]
}
