resource "aws_db_instance" "pgs" {
  identifier              = "${var.project_short_name}-db"
  allocated_storage       = var.db_allocated_storage
  storage_type            = var.db_storage_type
  engine                  = "postgres"
  engine_version          = "13.4"
  instance_class          = var.db_instance_class
  db_name                 = var.db_name
  username                = var.db_user
  password                = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.db_subnet_group.name
  publicly_accessible     = true
  skip_final_snapshot     = true
  apply_immediately       = true
  deletion_protection     = false
  vpc_security_group_ids  = [aws_security_group.db_sg.id]
  availability_zone       = var.azs[0]
  backup_retention_period = 5
  tags = {
    terraform: "infra"
    stage: var.stage
    Name: "${var.project_short_name}_db"
  }  
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "${var.project_short_name}-db-subnet-group"
  subnet_ids = [aws_subnet.public_subnet.id, aws_subnet.public_subnet_1.id]

  tags = {
    terraform: "infra"
    stage: var.stage
    Name: "${var.project_short_name}_db_subnet_groups"
  } 
}
