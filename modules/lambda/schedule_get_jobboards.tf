data "aws_s3_object" "schedule_get_jobboards_lambda_code" {
  bucket = var.jobs_bucket_id
  key    = "lambda/connectors/schedule_get_jobboards.zip"
}

resource "aws_lambda_function" "schedule_get_jobboards_lambda" {
  function_name                  = "schedule_get_jobboards_lambda"
  s3_bucket                      = data.aws_s3_object.schedule_get_jobboards_lambda_code.bucket
  s3_key                         = data.aws_s3_object.schedule_get_jobboards_lambda_code.key

  handler                        = "index.handler"
  runtime                        = "nodejs18.x"
  
  memory_size                    = 128
  timeout                        = 900

  role                           = var.aws_iam_role_schedule_get_jobboards_lambda_role_arn
  layers = [data.aws_lambda_layer_version.scrape_jobboard_lambda_layer.arn] # using the same layer as scrape lambda

  reserved_concurrent_executions = 1

    environment {
    variables = {
      SQS_QUEUE_URL = var.aws_sqs_queue_get_jobboards_queue_url
    }
  }

  tags = {
    Name        = "schedule_get_jobboards_lambda"
    Project     = "Jobs"
    Owner       = "DataEngg"
    Environment = "Production"
    Stage       = "Ingestion"
  }
}
