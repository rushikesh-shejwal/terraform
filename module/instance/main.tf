
resource "aws_security_group" "sg1" {
  name        = "Test Security Group"
  description = "Test SG"
  vpc_id      = var.vpc_id

  ingress {
    cidr_blocks = [var.my-ip]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }

  egress {
    cidr_blocks = [var.my-ip]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }

  tags = {
    Name = "Project Security Group"
  }

}

resource "aws_instance" "public_instance" {
  instance_type   = var.instance_type
  ami             = var.image_name
  subnet_id       = var.public_subnet_id
  security_groups = [aws_security_group.sg1.id]
  associate_public_ip_address = true
  key_name        = "inception"
  tags = {
    Name = "Public Instance"
  }
}

resource "aws_instance" "private_instance" {
  instance_type   = "t2.micro"
  ami             = var.image_name
  subnet_id       = var.private_subnet_id
  security_groups = [aws_security_group.sg1.id]
  key_name        = "inception"

  tags = {
    Name = "Private  Instance"
  }
}

output "public_ip" {
  description = "Public IP of Public Instance "
  value = aws_instance.public_instance.public_ip
}
