#Source: https://www.architect.io/blog/2021-03-30/create-and-manage-an-aws-ecs-cluster-with-terraform/
output "load_balancer_ip" {
  value = aws_lb.default_lb.dns_name
}

#from build_apache_ec2
output "web-address" {
  value = "${aws_instance.apache_ec2_instance.public_dns}:8080"
}
