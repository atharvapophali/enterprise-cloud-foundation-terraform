resource "aws_security_group" "rds_sg" {
  name        = "rds-security-group"
  description = "Allow PostgreSQL access"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name = "enterprise-db-subnet-group"

  subnet_ids = [
    var.private_subnet_1_id,
    var.private_subnet_2_id
  ]

  tags = {
    Name = "enterprise-db-subnet-group"
  }
}

resource "aws_db_instance" "postgres" {
  allocated_storage    = 20
  engine                = "postgres"
  engine_version        = "17.4"
  instance_class        = "db.t3.micro"

  db_name               = var.db_name
  username              = var.db_username
  password              = var.db_password

  publicly_accessible   = false
  skip_final_snapshot   = true

  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name

  tags = {
    Name = "enterprise-postgres-db"
  }
}