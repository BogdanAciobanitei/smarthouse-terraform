resource "aws_dynamodb_table" "device_events_table" {
  name           = "${var.environment}_device_events"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "reference"

  attribute {
    name = "reference"
    type = "S"
  }

  attribute {
    name = "houseReference"
    type = "S"
  }

  attribute {
    name = "deviceReference"
    type = "S"
  }

  global_secondary_index {
    name               = "${var.environment}_houseReference-deviceReference-index"
    hash_key           = "houseReference"
    range_key          = "deviceReference"
    write_capacity     = 1
    read_capacity      = 1
    projection_type    = "ALL"
  }

}

resource "aws_dynamodb_table" "devices_table" {
  name           = "${var.environment}_devices"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "houseReference"
  range_key = "deviceReference"

  attribute {
    name = "houseReference"
    type = "S"
  }

  attribute {
    name = "deviceReference"
    type = "S"
  }

}
