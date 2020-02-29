data "archive_file" "zip" {
  type        = "zip"
  source_file = "bin/aws-lambda-go"
  output_path = "aws-lambda-go.zip"
}

resource "aws_lambda_function" "hello" {
  function_name    = "hello"
  filename         = "aws-lambda-go.zip"
  handler          = "aws-lambda-go"
  source_code_hash = "data.archive_file.zip.output_base64sha256"
  role             = "${aws_iam_role.iam_for_lambda.arn}"
  runtime          = "go1.x"
  memory_size      = 128
  timeout          = 10
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

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