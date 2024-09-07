variable "jobs_bucket_id" {
  type = string
}

variable "aws_iam_role_scrape_jobboard_lambda_role_arn" {
  type = string
}

variable "aws_iam_role_schedule_scrape_jobboard_lambda_role_arn" {
  type = string
}

variable "aws_sqs_queue_scrape_jobboard_queue_arn" {
  type = string
}

variable "aws_sqs_queue_scrape_jobboard_queue_url" {
  type = string
}
