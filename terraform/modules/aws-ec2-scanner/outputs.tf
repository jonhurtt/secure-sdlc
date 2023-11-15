output "public_dns" {
  description = "IP Address of EC2 Scanner Instance"
  value = "${aws_instance.apache_ec2_instance.public_dns}"
}
