provider "aws" {
	access_key = "${var.aws_access_key}"
	secret_key = "${var.aws_secret_key}"
	region = "${var.aws_region}"
}

resource "aws_dynamodb_table" "test" {
    name = "test"
    read_capacity = 1
    write_capacity = 1
    hash_key = "key"
    range_key = "timestamp"
    attribute {
      name = "key"
      type = "S"
    }
    attribute {
      name = "timestamp"
      type = "N"
    }
}

resource "aws_iam_role_policy" "dynamo_db_api_logs_rw" {
    name = "dynamo_db_api_logs_rw"
    role = "${aws_iam_role.lambda_dynamo_db_api.id}"
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "CloudWatchRW",
            "Resource": "*",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Effect": "Allow"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "dynamo_db_api_data_rw" {
    name = "dynamo_db_api_data_rw"
    role = "${aws_iam_role.lambda_dynamo_db_api.id}"
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "DynamoDBRW",
            "Action": [
                "dynamodb:DeleteItem",
                "dynamodb:Get*",
                "dynamodb:PutItem",
                "dynamodb:Query",
                "dynamodb:Scan",
                "dynamodb:UpdateItem"
            ],
            "Effect": "Allow",
            "Resource": "*"
        }
      ]
}
EOF
}

resource "aws_iam_role" "lambda_dynamo_db_api" {
    name = "lambda_dynamo_db_api"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
