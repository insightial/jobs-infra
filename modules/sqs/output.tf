output "aws_sqs_queue_scrape_jobboard_queue_arn" {
    value = aws_sqs_queue.scrape_jobboard_queue.arn
}

output "aws_sqs_queue_scrape_jobboard_queue_url" {
  value = aws_sqs_queue.scrape_jobboard_queue.url
}

output "aws_sqs_queue_get_jobboards_queue_arn" {
    value = aws_sqs_queue.get_jobboards_queue.arn
}

output "aws_sqs_queue_get_jobboards_queue_url" {
  value = aws_sqs_queue.get_jobboards_queue.url
}
