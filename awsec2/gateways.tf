//gateways.tf
resource "aws_internet_gateway" "dmogiliver-env-gw" {
  vpc_id = "${aws_vpc.dmogiliver-env.id}"

tags {
    Name = "dmogiliver-env-gw"
  }
}
