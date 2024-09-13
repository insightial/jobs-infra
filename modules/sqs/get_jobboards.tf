resource "aws_sqs_queue" "get_jobboards_dlq" {
  name = "get_jobboards_dlq"
}

resource "aws_sqs_queue" "get_jobboards_queue" {
  name                       = "get_jobboards_queue"
# delay_seconds              = 5           # Optional: Delay before the message becomes available in the queue
  max_message_size           = 262144      # Optional: Max message size in bytes (default 256 KB)
  message_retention_seconds  = 86400       # Optional: Duration (in seconds) that the queue retains a message
  visibility_timeout_seconds = 300 # Optional: Duration (in seconds) that the visibility timeout for the queue is set to

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.get_jobboards_dlq.arn
    maxReceiveCount     = 3  # Number of times a message is delivered before being moved to the DLQ
  })

  tags = {
    Name        = "get_jobboards_queue"
    Project     = "Jobs"
    Owner       = "DataEngg"
    Environment = "Production"
    Stage       = "Ingestion"
  }
}
