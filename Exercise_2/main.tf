provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region = var.aws_region
}

data archive_file lambda_zip {
  type        = "zip"
  source_file = "greet_lambda.py"
  output_path = "lambda_function.zip"
}


resource "aws_lambda_function" "test_lambda" {
  function_name  = "ud-lambda-function"
  description    = "udacity project lambda funtion"
  handler        = "greet_lambda.lambda_handler"
  runtime        = "python3.6"
  filename         = data.archive_file.lambda_zip.output_path
  role             = aws_iam_role.lambda_role.arn
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

}

resource "aws_iam_role" "lambda_role" {
  name = "iam_for_lambda"
  assume_role_policy = file("iam/lambda-assume-role-policy.json")
}

resource "aws_iam_role_policy" "lambda_policy" {
  name = "lambda_policy"
  role = aws_iam_role.lambda_role.id
  policy = file("iam/lambda-policy.json")
  
}

