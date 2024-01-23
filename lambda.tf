resource "aws_iam_role" "lambda_ecr_role" {
  name = "lambda_ecr_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = ["lambda.amazonaws.com", "ecr.amazonaws.com"]
        }
      }
    ]
  })
}

resource "aws_iam_policy" "lambda_ecr_policy" {
  name        = "lambda_ecr_policy"
  description = "Policy for Lambda and ECR full access"
  
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = "*",
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_ecr_policy_attachment" {
  policy_arn = aws_iam_policy.lambda_ecr_policy.arn
  role       = aws_iam_role.lambda_ecr_role.name
}
resource "aws_lambda_function" "my_lambda_function" {
  function_name    = "docker-jenkins-lambda"
  role             = aws_iam_role.lambda_ecr_role.arn  # Assume you have an IAM role created for Lambda
  image_uri        = "948427039490.dkr.ecr.ap-south-1.amazonaws.com/lambdaxjenkins:latest"  # Replace with your ECR image URI
  package_type     = "Image"
  timeout          = 300  # Update with your desired timeout in seconds
  memory_size      = 512  # Update with your desired memory size in MB

  environment {
    variables = {
      KEY1 = "VALUE1",
      KEY2 = "VALUE2",
    }
  }

  depends_on = [aws_iam_role_policy_attachment.lambda_ecr_policy_attachment]
}
