# Buildng EC2 Instance with Apache and changing default webpage

data "aws_ami" "scanner_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "pc_scanner_instance" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web-sg.id]
  
  tags = var.tags

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y apache2
              sed -i -e 's/80/8080/' /etc/apache2/ports.conf
              curl -o index.html https://raw.githubusercontent.com/jonhurtt/secure-sdlc/main/html/index.html
              cp index.html /var/www/html/index.html
              systemctl restart apache2
              EOF
            
}


resource "aws_security_group" "scanner-sg" {
  name = "scanner-sg"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}