resource "aws_rds_cluster" "jobs_aurora_cluster" {
  cluster_identifier      = "jobs-aurora-cluster"
  engine                  = "aurora-postgresql"
  engine_version          = "13"
  master_username         = var.aws_jobs_listing_master_username
  master_password         = var.aws_jobs_listing_master_password
  db_subnet_group_name    = var.aws_db_subnet_group_jobs_aurora_db_subnet_group_name
  vpc_security_group_ids  = [var.aws_security_group_jobs_aurora_sg_id]
  skip_final_snapshot     = true

  tags = {
    Name    = "jobs_aurora_cluster"
    Project = "Jobs"
    Owner   = "DataEngg"
  }
}

resource "aws_rds_cluster_instance" "jobs_aurora_instance" {
  identifier              = "jobs-aurora-instance"
  cluster_identifier      = aws_rds_cluster.jobs_aurora_cluster.id
  instance_class          = "db.t4g.medium"
  engine                  = "aurora-postgresql"
  engine_version          = "13" 
  db_subnet_group_name    = var.aws_db_subnet_group_jobs_aurora_db_subnet_group_name
  publicly_accessible     = false

  tags = {
    Name    = "jobs_aurora_instance"
    Project = "Jobs"
    Owner   = "DataEngg"  
  }
}
