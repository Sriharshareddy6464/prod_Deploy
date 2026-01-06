provider "aws" {
  region = "ap-south-1"
}

resource "aws_key_pair" "prod_key" {
  key_name   = "proddeploy-key"
  public_key = file("proddeploy-key.pub")
}

resource "aws_security_group" "prod_sg" {
  name        = "proddeploy-sg"
  description = "Allow SSH and HTTP"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "prod_ec2" {
  ami           = "ami-0f5ee92e2d63afc18" # Ubuntu 22.04 (ap-south-1)
  instance_type = "t3.micro"
  key_name      = aws_key_pair.prod_key.key_name
  security_groups = [aws_security_group.prod_sg.name]

  tags = {
    Name = "proddeploy-server"
  }
}

output "public_ip" {
  value = aws_instance.prod_ec2.public_ip
}