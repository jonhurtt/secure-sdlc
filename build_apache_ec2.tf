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
    git_commit                 = "282151d89a5e91d764e4284eb3a6301cb6dc3b4d"
    git_file                   = "build_apache_ec2.tf"
    git_last_modified_at       = "2023-10-26 18:36:42"
    git_last_modified_by       = "JonHurtt@gmail.com"
    git_modifiers              = "JonHurtt"
    git_org                    = "jonhurtt"
    git_repo                   = "secure-sdlc"
    yor_name                   = "apache_ec2_instance"
    yor_trace                  = "7e1d1c1e-2abc-482d-98f6-e4ad18537b0c"
    securegit_commit           = "282151d89a5e91d764e4284eb3a6301cb6dc3b4d"
    securegit_file             = "build_apache_ec2.tf"
    securegit_last_modified_at = "2023-10-26 18:36:42"
    securegit_last_modified_by = "JonHurtt@gmail.com"
    securegit_modifiers        = "JonHurtt"
    securegit_org              = "jonhurtt"
    securegit_repo             = "secure-sdlc"
    secureyor_name             = "apache_ec2_instance"
    secureyor_trace            = "473a9b30-87a3-48e4-87e0-cc1525acf1d5"
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
    git_commit                 = "282151d89a5e91d764e4284eb3a6301cb6dc3b4d"
    git_file                   = "build_apache_ec2.tf"
    git_last_modified_at       = "2023-10-26 18:36:42"
    git_last_modified_by       = "JonHurtt@gmail.com"
    git_modifiers              = "JonHurtt"
    git_org                    = "jonhurtt"
    git_repo                   = "secure-sdlc"
    yor_name                   = "web-sg"
    yor_trace                  = "64c722a3-1fab-4316-b8e6-e6bf3f46ea73"
    securegit_commit           = "282151d89a5e91d764e4284eb3a6301cb6dc3b4d"
    securegit_file             = "build_apache_ec2.tf"
    securegit_last_modified_at = "2023-10-26 18:36:42"
    securegit_last_modified_by = "JonHurtt@gmail.com"
    securegit_modifiers        = "JonHurtt"
    securegit_org              = "jonhurtt"
    securegit_repo             = "secure-sdlc"
    secureyor_name             = "web-sg"
    secureyor_trace            = "7c3d491b-beca-4d39-94d2-d414a9a2b018"
  }
}

/*
Moved to outputs.tf
output "web-address" {
  value = "${aws_instance.web.public_dns}:8080"
}
*/