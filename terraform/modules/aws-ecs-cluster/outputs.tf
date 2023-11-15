output "load_balancer_ip" {
  description = "DNS Name for Load Balancer"
  value = aws_lb.default_lb.dns_name
}
