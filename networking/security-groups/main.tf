resource "aws_security_group" "ec2_outboud_sg" {
  name = "${var.environment}-ec2_outboud_sg"
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = [
      "0.0.0.0/0"]
  }
}
resource "aws_security_group" "ec2_inbound_ssh_sg" {
  name = "${var.environment}-ec2_inbound_ssh_sg"
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = [
      "79.118.94.128/32"]
  }
}
resource "aws_security_group" "ec2_inbound_http_sg" {
  name = "${var.environment}-ec2_inbound_http_sg"
  ingress {
    from_port = 8090
    protocol = "tcp"
    to_port = 8090
    cidr_blocks = [
      "0.0.0.0/0"]
  }
}

data "aws_availability_zones" "available" {
  state = "available"

}

resource "aws_security_group" "elastic_mq_sg" {
  //  vpc_id = "${data.aws_vpc.vpc.id}"
  name = "${var.environment}-Security group for AMQ cluster."

  ingress {
    from_port = 0
    protocol = "-1"
    to_port = 0

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
}

data "aws_vpc" "selected" {
  id = "${var.vpc_id}"
}
