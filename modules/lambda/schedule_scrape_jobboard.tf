data "aws_s3_object" "schedule_scrape_jobboard_lambda_code" {
  bucket = var.jobs_bucket_id
  key    = "lambda/ingestion/schedule_scrape_jobboard.zip"
}

resource "aws_lambda_function" "schedule_scrape_jobboard_lambda" {
  function_name = "schedule_scrape_jobboard_lambda"
  s3_bucket     = data.aws_s3_object.schedule_scrape_jobboard_lambda_code.bucket
  s3_key        = data.aws_s3_object.schedule_scrape_jobboard_lambda_code.key

  handler = "index.handler"
  runtime = "nodejs18.x"

  memory_size = 128
  timeout     = 900

  role   = var.aws_iam_role_schedule_scrape_jobboard_lambda_role_arn
  layers = [data.aws_lambda_layer_version.schedule_scrape_jobboard_lambda_layer.arn]

  reserved_concurrent_executions = 1

  environment {
    variables = {
      SQS_QUEUE_URL = var.aws_sqs_queue_scrape_jobboard_queue_url
    }
  }

  tags = {
    Name        = "schedule_scrape_jobboard_lambda"
    Project     = "Jobs"
    Owner       = "DataEngg"
    Environment = "Production"
    Stage       = "Ingestion"
  }
}

data "aws_lambda_layer_version" "schedule_scrape_jobboard_lambda_layer" {
  layer_name = "schedule_scrape_jobboard_lambda_layer"
}

# data "aws_s3_object" "schedule_scrape_jobboard_lambda_layer_code" {
#   bucket = var.jobs_bucket_id
#   key    = "lambda/ingestion/schedule_scrape_jobboard_layer.zip"
# }

# resource "aws_lambda_layer_version" "schedule_scrape_jobboard_lambda_layer" {
#   layer_name          = "schedule_scrape_jobboard_lambda_layer"
#   s3_bucket           = data.aws_s3_object.schedule_scrape_jobboard_lambda_layer_code.bucket
#   s3_key              = data.aws_s3_object.schedule_scrape_jobboard_lambda_layer_code.key
#   compatible_runtimes = ["nodejs18.x"]
# }
