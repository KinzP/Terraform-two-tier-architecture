# Create EC2 instance for public subnet 1
resource "aws_instance" "web_server1_P18"   {             
	ami = "ami-090fa75af13c156b4"
	instance_type = "t2.micro"
	security_groups = [aws_security_group.publicsg_P18.id]
	subnet_id = aws_subnet.public_subnet1a_P18.id
	
	user_data = <<-EOF
        #!/bin/bash
        yum update -y
        yum install httpd -y
        systemctl start
        systemctl enable
        echo '<h1>Hello LUIT Red Team!</h1>' > /usr/share/nginx/html/index.html
        EOF
}

# Create EC2 instance for public subnet 2
resource "aws_instance" "web_server2_P18" {             
	ami = "ami-090fa75af13c156b4"
	instance_type = "t2.micro"
    security_groups = [aws_security_group.publicsg_P18.id]
	subnet_id = aws_subnet.public_subnet1b_P18.id

	user_data = <<-EOF
        #!/bin/bash
        yum update -y
        yum install httpd -y
        systemctl start
        systemctl enable 
        echo '<h1>LUIT Red Team = BEST TEAM!</h1>' > /usr/share/nginx/html/index.html
        EOF
}
# Create Application load balancer
resource "aws_alb" "apploadb_P18"    {
    name = "apploadb_P18"
    load_balancer_type = "application"
    internal = false
    subnets         = [aws_subnet.public_subnet1a_P18.id, aws_subnet.public_subnet1b_P18.id]
    security_groups = [aws_security_group.publicsg_P18.id]
}

resource "aws_lb_listener" "loadb_listener_P18" {
  load_balancer_arn = aws_lb.loadb_listener_P18.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.loadb_tg_P18.arn
  }
}

resource "aws_lb_target_group" "loadb_tg_P18" {
  name     = ""loadb_tg_P18"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.P18.id
}

resource "aws_lb_target_group_attachment" "target_grp_P18_1a" {
  target_group_arn = aws_lb_target_group.loadb_tg_P18.arn
  target_id        = aws_instance.web_server1_P18.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "target_grp_P18_1b" {
  target_group_arn = aws_lb_target_group.loadb_tg_P18.arn
  target_id        = aws_instance.web_server2_P18.id
  port             = 80
}