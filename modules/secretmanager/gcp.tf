resource "aws_secretsmanager_secret" "google_cloud_platform_api_key" {
  name        = "google_cloud_platform_api_key"
  description = "API Key for Google Cloud Platform"

  tags = {
    Name    = "google_cloud_platform_api_key"
    Owner   = "DataEngg"
  }
}
