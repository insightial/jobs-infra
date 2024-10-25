terraform {
  backend "s3" {
    bucket = "jobs-infra-terraform-state"
    key = "terraform.tfstate"
    region = "us-east-1"
  }
}

module "iam" {
  source = "./modules/iam"
}

module "s3" {
  source = "./modules/s3"
}

module "secretmanager" {
  source = "./modules/secretmanager"
}

module "sqs" {
  source = "./modules/sqs"
}

module "sql" {
  source = "./modules/sql"

  aws_jobs_listing_master_username                     = module.secretmanager.db_credentials["master_username"]
  aws_jobs_listing_master_password                     = module.secretmanager.db_credentials["master_password"]
  aws_db_subnet_group_jobs_aurora_db_subnet_group_name = aws_db_subnet_group.jobs_subnet_group.name
  aws_security_group_jobs_aurora_sg_id                 = aws_security_group.jobs_security_group.id

}

module "lambda" {
  source = "./modules/lambda"

  jobs_bucket_id = module.s3.jobs_bucket_id
  aws_iam_role_scrape_jobboard_lambda_role_arn = module.iam.aws_iam_role_scrape_jobboard_lambda_role_arn
  aws_iam_role_schedule_scrape_jobboard_lambda_role_arn = module.iam.aws_iam_role_schedule_scrape_jobboard_lambda_role_arn  
  aws_sqs_queue_scrape_jobboard_queue_arn = module.sqs.aws_sqs_queue_scrape_jobboard_queue_arn
  aws_sqs_queue_scrape_jobboard_queue_url = module.sqs.aws_sqs_queue_scrape_jobboard_queue_url
  aws_iam_role_get_jobboards_lambda_role_arn = module.iam.aws_iam_role_get_jobboards_lambda_role_arn
  aws_sqs_queue_get_jobboards_queue_arn = module.sqs.aws_sqs_queue_get_jobboards_queue_arn
  aws_sqs_queue_get_jobboards_queue_url = module.sqs.aws_sqs_queue_get_jobboards_queue_url
  aws_iam_role_schedule_get_jobboards_lambda_role_arn = module.iam.aws_iam_role_schedule_get_jobboards_lambda_role_arn
}
