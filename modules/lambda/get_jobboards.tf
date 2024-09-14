data "aws_s3_object" "get_jobboards_lambda_code" {
  bucket = var.jobs_bucket_id
  key    = "lambda/connectors/get_jobboards.zip"
}

resource "aws_lambda_function" "get_jobboards_lambda" {
  function_name                  = "get_jobboards_lambda"
  s3_bucket                      = data.aws_s3_object.get_jobboards_lambda_code.bucket
  s3_key                         = data.aws_s3_object.get_jobboards_lambda_code.key

  handler                        = "index.handler"
  runtime                        = "nodejs18.x"
  
  memory_size                    = 128
  timeout                        = 900

  role                           = var.aws_iam_role_get_jobboards_lambda_role_arn
  layers                         = [aws_lambda_layer_version.scrape_jobboard_lambda_layer.arn] # using the same layer as scrape lambda

  tags = {
    Name        = "get_jobboards_lambda"
    Project     = "Jobs"
    Owner       = "DataEngg"
    Environment = "Production"
    Stage       = "Ingestion"
  }
}

resource "aws_lambda_event_source_mapping" "sqs_get_jobboards_lambda_trigger" {
  event_source_arn  = var.aws_sqs_queue_get_jobboards_queue_arn
  function_name     = aws_lambda_function.get_jobboards_lambda.arn
  batch_size        = 10  # Control the number of messages processed per Lambda invocation
}
