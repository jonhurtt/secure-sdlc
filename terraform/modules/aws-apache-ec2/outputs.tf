output "public_dns" {
  description = "IP Address of EC2 Apache Instance"
  value = "${aws_instance.apache_ec2_instance.public_dns}"
}
