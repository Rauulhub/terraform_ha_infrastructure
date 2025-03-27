variable "ami_id" {
    description = "ami id"
    type = string
}

variable "instance_type" {
    description = "instance type"
    type = string
}

variable "vpc_id" {
  type = string
  description = "ID of VPC"
}

variable "subnet_public_a" {
  type = string
  description = "Id of public subnet az-a"
  
}
variable "subnet_public_b" {
  type = string
  description = "Id of public subnet az-b"
  
}

variable "subnet_private_a" {
  type = string
  description = "Id of private subnet az-a"
  
}
variable "subnet_private_b" {
  type = string
  description = "Id of private subnet az-b"
  
}

variable "subnet_private_management" {
  type = string
  description = "ID private management subnet"
}

variable "key_pair" {
  type = string     
  description = "key pair for ssh connection"
  
}