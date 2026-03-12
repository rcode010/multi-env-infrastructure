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
  key_name = aws_key_pair.deployer.key_name
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
  ingress {
  from_port   = 5432
  to_port     = 5432
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

}
resource "aws_key_pair" "deployer" {
  key_name = "albert's key"
  public_key = file("~/.ssh/id_rsa.pub")
}

# Database
resource "aws_db_instance" "portfolio_db" {
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "postgres"
  engine_version       = "16"
  instance_class       = "db.t3.micro"
vpc_security_group_ids = [aws_security_group.portfolio_sg.id]
  username             = "alb"
  password             = var.db_password

  parameter_group_name = "default.postgres16"
  publicly_accessible = true

  skip_final_snapshot  = true
}

output "db_endpoint" {
  value = aws_db_instance.portfolio_db.endpoint
}