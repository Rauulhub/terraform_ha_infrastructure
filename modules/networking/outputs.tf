output "vpc_id" {
  description = "Id of the VPC"
  value       = aws_vpc.lab_vpc.id 
}

output "subnet_private_management" {
  description = "Id of private management subnet"
  value       = aws_subnet.subnet_private_management.id
}

output "subnet_public_a" {
  description = "Id of public subnet az-a"
  value       = aws_subnet.subnet_public_a.id
}
output "subnet_public_b" {
  description = "Id of public subnet az-b"
  value       = aws_subnet.subnet_public_b.id
}

output "subnet_private_a" {
  description = "Id of private subnet az-a"
  value       = aws_subnet.subnet_private_a.id
}
output "subnet_private_b" {
  description = "Id of private subnet az-b"
  value       = aws_subnet.subnet_private_b.id
}

output "subnet_private_db" {
  description = "subnet for db"
  value = aws_subnet.subnet_private_db.id
}
output "subnet_private_db_ha" {
  description = "subnet for db ha"
  value = aws_subnet.subnet_private_db_ha.id
}

