resource "aws_sqs_queue" "events_queue" {
  name = "${var.environment}-EventsQueue"
}

resource "aws_mq_broker" "example" {
  broker_name = "${var.environment}_cegeka_smarthouse"

  engine_type = "ActiveMQ"
  engine_version = "5.15.0"
  host_instance_type = "mq.t2.micro"
  security_groups = [
    "${var.elastic_mq_security_group_id}"
  ]

  publicly_accessible = true

  user {
    console_access = true
    username = "user"
    password = "password12345"
  }
}