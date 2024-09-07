resource "aws_db_instance" "jobs_rds_instance" {
  identifier              = "jobs-rds-instance"
  engine                  = "postgres"
  engine_version          = "13"
  instance_class          = "db.t4g.small"
  allocated_storage       = 20
  storage_type            = "gp2"
  db_subnet_group_name    = var.aws_db_subnet_group_jobs_aurora_db_subnet_group_name
  vpc_security_group_ids  = [var.aws_security_group_jobs_aurora_sg_id]
  publicly_accessible     = true
  username                = var.aws_jobs_listing_master_username
  password                = var.aws_jobs_listing_master_password
  skip_final_snapshot     = true
  apply_immediately       = true

  tags = {
    Name    = "jobs_rds_instance"
    Project = "Jobs"
    Owner   = "DataEngg"
  }
}
