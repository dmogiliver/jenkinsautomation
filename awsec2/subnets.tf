//subnets.tf
resource "aws_route_table" "route-table-dmogiliver-env" {
  vpc_id = "${aws_vpc.dmogiliver-env.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.dmogiliver-env-gw.id}"
  }

  tags {
    Name = "dmogiliver-env-route-table"
  }
}

resource "aws_route_table_association" "subnet-association" {
  subnet_id      = "${aws_subnet.subnet-one.id}"
  route_table_id = "${aws_route_table.route-table-dmogiliver-env.id}"
}

resource "aws_subnet" "subnet-one" {
  cidr_block = "10.0.0.0/16"
  vpc_id = "${aws_vpc.dmogiliver-env.id}"
}