# TODO: Define the output variable for the lambda function.
output "lambda_arn" {
  value       = aws_lambda_function.test_lambda.function_name
  description = "ARN of the given lambda."
}
