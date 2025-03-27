output "frontend_private_ip" {
  value = aws_instance.ec2_frontend.private_ip
}
output "backend_private_ip" {
  value = aws_instance.ec2_backend.private_ip
}
output "management_private_ip" {
  value = aws_instance.ec2_management.public_ip
}

