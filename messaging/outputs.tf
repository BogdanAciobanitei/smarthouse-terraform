output "event_queue_arn" {
  value = "${aws_sqs_queue.events_queue.arn}"
}