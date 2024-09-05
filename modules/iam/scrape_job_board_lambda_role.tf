resource "aws_iam_role" "scrape_job_board_lambda_role" {
  name = "scrape_job_board_lambda_role"

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
    Name    = "scrape_job_board_lambda_role"
    Project = "AdOracle"
    Owner   = "DataEngg"
    Stage   = "Ingestion"
  }
}

resource "aws_iam_role_policy_attachment" "scrape_job_board_lambda_execution_role_attachment" {
  role       = aws_iam_role.scrape_job_board_lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

/*
resource "aws_iam_policy" "scrape_job_board_lambda_policy" {
  name        = "scrape_job_board_lambda_policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = []
  })

  tags = {
    Name        = "scrape_job_board_lambda_policy"
    Project     = "AdOracle"
    Owner       = "DataEngg"
    Stage       = "Ingestion"
    Environment = "Production"

  } 
}

resource "aws_iam_role_policy_attachment" "scrape_job_board_lambda_policy_attachment" {
  role       = aws_iam_role.scrape_job_board_lambda_role.name
  policy_arn = aws_iam_policy.scrape_job_board_lambda_policy.arn
}
*/
