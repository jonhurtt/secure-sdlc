# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0
# Buildng EC2 Instance with Apache and changing default webpage

/* Moved to versions.tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.52.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
  }
  required_version = ">= 1.1.0"
}

provider "aws" {
  region = "us-east-1"
}
*/

#resource "random_pet" "sg" {}

data "aws_ami" "ubuntu" {
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

/*
resource "aws_instance" "web" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web-sg.id]

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y apache2
              sed -i -e 's/80/8080/' /etc/apache2/ports.conf
              echo "<p>Hello World!<br><br>this is part of the secure-sdlc created by Jonathan Hurtt (https://github.com/jonhurtt/secure-sdlc/)<p>" > /var/www/html/index.html
              systemctl restart apache2
              EOF
}*/

resource "aws_instance" "apache_ec2_instance" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web-sg.id]

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y apache2
              sed -i -e 's/80/8080/' /etc/apache2/ports.conf
              curl -o index.html https://raw.githubusercontent.com/jonhurtt/secure-sdlc/main/html/index.html
              cp index.html /var/www/html/index.html
              systemctl restart apache2
              EOF
  tags = {
    prod_git_commit           = "282151d89a5e91d764e4284eb3a6301cb6dc3b4d"
    prod_git_file             = "build_apache_ec2.tf"
    prod_git_last_modified_at = "2023-10-26 18:36:42"
    prod_git_last_modified_by = "JonHurtt@gmail.com"
    prod_git_modifiers        = "JonHurtt"
    prod_git_org              = "jonhurtt"
    prod_git_repo             = "secure-sdlc"
    prod_yor_name             = "apache_ec2_instance"
    prod_yor_trace            = "41473403-858d-4e3c-a5c3-cda10aad67a8"
  }
}


resource "aws_security_group" "web-sg" {
  #name = "${random_pet.sg.id}-sg"
  name = "web-sg"
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  // connectivity to ubuntu mirrors is required to run `apt-get update` and `apt-get install apache2`
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    prod_git_commit           = "282151d89a5e91d764e4284eb3a6301cb6dc3b4d"
    prod_git_file             = "build_apache_ec2.tf"
    prod_git_last_modified_at = "2023-10-26 18:36:42"
    prod_git_last_modified_by = "JonHurtt@gmail.com"
    prod_git_modifiers        = "JonHurtt"
    prod_git_org              = "jonhurtt"
    prod_git_repo             = "secure-sdlc"
    prod_yor_name             = "web-sg"
    prod_yor_trace            = "ce770ff8-6579-4da4-b128-58cb8c09dd1c"
  }
}

/*
Moved to outputs.tf
output "web-address" {
  value = "${aws_instance.web.public_dns}:8080"
}
*/