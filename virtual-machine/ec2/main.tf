resource "aws_iam_role" "ec2_role" {
  name = "${var.environment}-ec2_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "ec2_policy" {
  role = "${aws_iam_role.ec2_role.name}"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Resource": [
        "*"
      ],
      "Action": [
        "*"
      ]
    }
  ]
}
POLICY
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.environment}-ec2_profile"
  role = "${aws_iam_role.ec2_role.name}"
}

resource "aws_instance" "ec2_instance" {
  ami = "ami-0525b93bd21404da5"
  instance_type = "t2.micro"

  security_groups = "${var.security_groups}"
  key_name = "smarthouse-key"

  iam_instance_profile = "${aws_iam_instance_profile.ec2_profile.name}"

  tags = {
    Name = "${var.environment}-ec2_instance"
  }
}
