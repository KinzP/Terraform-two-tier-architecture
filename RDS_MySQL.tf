# Database subnet group
resource "aws_db_subnet_group" "db_subnet"  {
    name       = "db_subnet"
    subnet_ids = [aws_subnet.private_subnet1.id, aws_subnet.private_subnet2.id]
}

# Security group for database tier
resource "aws_security_group" "db_sg" {
    name = "db_sg"
    description = "allow traffic only from web_sg"
    vpc_id      = aws_vpc.vpc.id

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

# Database instance in private subnet 1
resource "aws_db_instance" "db1" {
    allocated_storage    = 5
    engine               = "mysql"
    engine_version       = "5.7"
    instance_class       = "db.t3.micro"
    db_subnet_group_name = "db_subnet"
    vpc_security_group_ids = [aws_security_group.db_sg.id]
    username             = "admin"
    password             = "password"
    skip_final_snapshot  = true