# Create a VPC
resource "aws_vpc" "TF_P18" {
  cidr_block = "10.0.0.0/16"
}
  tags = {
    Name = "VPC_P18"
  }

# Create 2 Public Subnets
resource "aws_subnet" "public_subnet1a_P18" {
  vpc_id            = aws_vpc.TF_P18.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "public subnet 1a_P18"
  }
}

resource "aws_subnet" "public_subnet1b_P18" {
  vpc_id            = aws_vpc.TF_P18.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "public subnet 1b_P18"
  }
}


# Create 2 Private Subnets
resource "aws_subnet" "private_subnet_1a_P18" {
  vpc_id            = aws_vpc.TF_P18.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = false
  tags = {
    Name = "private subnet 1a_P18"
  }
}
resource "aws_subnet" "private_subnet_1b_P18" {
  vpc_id            = aws_vpc.TF_P18.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = false
  tags = {
    Name = "private subnet 1b_P18"
  }
}