//network.tf

resource "aws_vpc" "dmogiliver-env" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags {
    Name = "dmogiliver-env"
  }
}

resource "aws_eip" "ip-dmogiliver-env" {
  instance = "${aws_instance.dmogiliver-ec2-instance.id}"
  vpc      = true
}
