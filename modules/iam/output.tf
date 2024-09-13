output "aws_iam_role_scrape_jobboard_lambda_role_arn" {
  value = aws_iam_role.scrape_job_board_lambda_role.arn
}

output "aws_iam_role_schedule_scrape_jobboard_lambda_role_arn" {
  value = aws_iam_role.scheule_scrape_job_board_lambda_role.arn
}
output "aws_iam_role_get_jobboards_lambda_role_arn" {
  value = aws_iam_role.get_job_boards_lambda_role.arn
}
