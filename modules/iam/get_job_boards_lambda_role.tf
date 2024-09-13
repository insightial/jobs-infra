resource "aws_iam_role" "get_job_boards_lambda_role" {
  name = "get_job_boards_lambda_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Effect = "Allow"
        Sid    = ""
      },
    ]
  })

  tags = {
    Name    = "get_job_boards_lambda_role"
    Project = "Jobs"
    Owner   = "DataEngg"
    Stage   = "Ingestion"
  }
}

resource "aws_iam_role_policy_attachment" "get_job_boards_lambda_execution_role_attachment" {
  role       = aws_iam_role.get_job_boards_lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_policy" "get_job_boards_lambda_policy" {
  name        = "get_job_boards_lambda_policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes",
          "sqs:ChangeMessageVisibility",
          "sqs:GetQueueUrl"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action   = "secretsmanager:GetSecretValue",
        Effect   = "Allow",
        Resource = "*"
      },
      {
        Action = [
          "rds:DescribeDBInstances"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })

  tags = {
    Name        = "get_job_boards_lambda_policy"
    Project     = "Jobs"
    Owner       = "DataEngg"
    Stage       = "Ingestion"
    Environment = "Production"

  } 
}

resource "aws_iam_role_policy_attachment" "get_job_boards_lambda_policy_attachment" {
  role       = aws_iam_role.get_job_boards_lambda_role.name
  policy_arn = aws_iam_policy.get_job_boards_lambda_policy.arn
}
