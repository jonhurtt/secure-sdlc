output "public_dns" {
  description = "IP Address of EC2 Scanner Instance"
  value = "${aws_instance.pc_scanner_instance.public_dns}"
}
