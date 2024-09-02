data "aws_secretsmanager_secret_version" "jobs_listing_aurora_credentials_version" {
  secret_id = aws_secretsmanager_secret.jobs_listing_aurora_credentials.id
}

locals {
  db_credentials = jsondecode(data.aws_secretsmanager_secret_version.jobs_listing_aurora_credentials_version.secret_string)
}

output "db_credentials" {
  value = local.db_credentials
}

