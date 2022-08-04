# Create Security Groups
resource "aws_security_group" "publicsg_P18" {
  name        = "publicsg_P18"
  description = "Allow web to ec2 instances and ssh traffic"
  vpc_id      = aws_vpc.TF_P18.id

  ingress {
    from_port         = 22
    to_port           = 22
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
  }
   ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["10.0.0.0/16"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]

  }
}
