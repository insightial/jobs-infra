data "aws_s3_object" "scrape_jobboard_lambda_code" {
  bucket = var.jobs_bucket_id
  key    = "lambda/ingestion/scrape_jobboard.zip"
}

resource "aws_lambda_function" "scrape_jobboard_lambda" {
  function_name                  = "scrape_jobboard_lambda"
  s3_bucket                      = data.aws_s3_object.scrape_jobboard_lambda_code.bucket
  s3_key                         = data.aws_s3_object.scrape_jobboard_lambda_code.key

  handler                        = "index.handler"
  runtime                        = "nodejs18.x"
  
  memory_size                    = 128
  timeout                        = 30

  role                           = var.aws_iam_role_scrape_jobboard_lambda_role_arn
  layers                         = [aws_lambda_layer_version.scrape_jobboard_lambda_layer.arn]

  reserved_concurrent_executions = 100

  tags = {
    Name        = "scrape_jobboard_lambda"
    Project     = "Jobs"
    Owner       = "DataEngg"
    Environment = "Production"
    Stage       = "Ingestion"
  }
}

data "aws_s3_object" "scrape_jobboard_lambda_layer_code" {
  bucket = var.jobs_bucket_id
  key    = "lambda/ingestion/scrape_jobboard_layer.zip"
}

resource "aws_lambda_layer_version" "scrape_jobboard_lambda_layer" {
  layer_name         = "scrape_jobboard_lambda_layer"
  s3_bucket          = data.aws_s3_object.scrape_jobboard_lambda_layer_code.bucket
  s3_key             = data.aws_s3_object.scrape_jobboard_lambda_layer_code.key
  compatible_runtimes = ["nodejs18.x"]
}

resource "aws_lambda_event_source_mapping" "sqs_scrape_jobboard_lambda_trigger" {
  event_source_arn  = var.aws_sqs_queue_scrape_jobboard_queue_arn
  function_name     = aws_lambda_function.scrape_jobboard_lambda.arn
  batch_size        = 1  # Control the number of messages processed per Lambda invocation
}
