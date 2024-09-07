resource "aws_secretsmanager_secret" "jobs_listing_aurora_credentials" {
  name        = "jobs_listing_aurora_credentials"
  description = "Credentials for jobs listing cluster in AWS Aurora"

  tags = {
    Name    = "jobs_listing_aurora_credentials"
    Owner   = "DataEngg"
    Project = "Jobs"
  }
}
