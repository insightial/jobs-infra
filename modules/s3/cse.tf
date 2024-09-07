resource "aws_s3_bucket" "jobs_cse" {
  bucket = "jobs-cse"

  tags = {
    Name        = "jobs-cse"
    Project     = "Jobs"
    Owner       = "DataEngg"
    Environment = "Production"
    Stage       = "Ingestion"
  }
}

resource "aws_s3_bucket_ownership_controls" "jobs_cse_ownership_controls" {
  bucket = aws_s3_bucket.jobs_cse.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "jobs_cse_acl" {
  depends_on = [aws_s3_bucket_ownership_controls.jobs_cse_ownership_controls]

  bucket = aws_s3_bucket.jobs_cse.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "jobs_cse_versioning" {
  bucket = aws_s3_bucket.jobs_cse.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "jobs_cse_server_side_encryption_configuration" {
  bucket = aws_s3_bucket.jobs_cse.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "jobs_cse_lifecycle_configuration" {
  bucket = aws_s3_bucket.jobs_cse.id

  rule {
    id     = "transition-to-glacier"
    status = "Enabled"

    transition {
      days          = 30
      storage_class = "GLACIER"
    }
  }
}
