//servers.tf
resource "aws_instance" "dmogiliver-ec2-instance" {
  ami = "${var.ami_id}"
  instance_type = "t2.micro"
  security_groups = ["${aws_security_group.ingress-all-dmogiliver.id}"]
  key_name = "dmogiliver-IAM-keypair2"

tags {
    Name = "${var.ami_name}"
  }

subnet_id = "${aws_subnet.subnet-one.id}"
}

output "ip" {
  value = "${aws_eip.ip-dmogiliver-env.public_ip}"
}
