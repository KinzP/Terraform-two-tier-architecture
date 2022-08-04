# Create RDS MySQL instance
resource "aws_db_instance" "db_P18" {
  allocated_storage           = 5
  engine                      = "mysql"
  engine_version              = "5.7"
  instance_class              = "db.t2.micro"
  db_name                     = "database_P18"
  username                    = "adminRed"
  password                    = "password"
  parameter_group_name        = "default.mysql5.7"
  vpc_security_group_ids      = EDIT
  allow_major_version_upgrade = true
  auto_minor_version_upgrade  = true
  multi_az                    = false
  skip_final_snapshot         = true
  
  # Create Database subnet group
resource "aws_db_subnet_group" "db_subnet_P18"  {
    name       = "db_subnet_P18"
    subnet_ids = [aws_subnet.private_subnet1.id, aws_subnet.private_subnet2.id]
}

# Security group for database tier
resource "aws_security_group" "Private_sg_P18" {
    name = "db_sg"
    description = "Allow web tier and ssh traffic"
    vpc_id      = aws_vpc.TF_P18.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.web_sg.id]
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.web_sg.id]
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
