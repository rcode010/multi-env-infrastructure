# Provider Block
provider "aws" {
    profile = "default"
    region = "eu-north-1"
  
}

# Resources Block
resource "aws_instance" "portfolio_api" {
  ami = "ami-056335ec4a8783947"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.portfolio_sg.id]
  tags = {
    Name= "portfolio-prod-1"
  }
}

resource "aws_security_group" "portfolio_sg" {
  name = "my-security-group"
  description = "allow SSH and HTTP"

  ingress{
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress{
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}