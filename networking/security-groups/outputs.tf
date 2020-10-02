output "ec2_inbound_ssh_sg" {
  value = aws_security_group.ec2_inbound_ssh_sg.name
}
output "ec2_inbound_http_sg" {
  value = aws_security_group.ec2_inbound_http_sg.name
}

output "ec2_outboud_sg" {
  value = aws_security_group.ec2_outboud_sg.name
}

output "elastic_mq_security_group_id" {
  value = "${aws_security_group.elastic_mq_sg.id}"
}