resource "aws_secretsmanager_secret" "jobs_cse" {
  name        = "jobs_cse"
  description = "Credentials for Google's Custom Search Engine"

  tags = {
    Name    = "jobs_cse"
    Project = "Jobs"
    Owner   = "DataEngg"
  }
}
