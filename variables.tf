variable "aws-region" {
    description = "aws region"
    type = string
    default = "us-east-1"
}

variable "environment"{
    description = "environment"
    type = string
    default = "default"
}

variable "access_key" {
    default = ""
    type = string
}

variable "secret_key" {
    default = ""
    type = string
}
#networking
variable "vpc_name" {
    description = "lab-vpc"
    type = string
    default = "lab_vpc"
}

variable "vpc_cidr" {
    description = "vpc cidr"
    type = string
    default = "10.1.0.0/25"
}

variable "vpc_az" {
    description = "availability zones"
    type = list(string)
    default = ["us-east-1a","us-east-1b"]
}

variable "vpc_public_subnet" {
    description = "public subnet frontend, para dos Az"
    type = list(string)
    default = ["10.1.0.0/28", "10.1.0.80/28"]
}

variable "vpc_private_subnet" {
    description = "private subnets backend and management y una mas para backend az-b"
    type = list(string)
    default = ["10.1.0.16/28","10.1.0.32/28","10.1.0.96/28"]
}

variable "vpc_db_subnet" {
  description = "db subnets"
  type = list(string)
  default = ["10.1.0.48/28", "10.1.0.64/28"] 
}
#ec2
variable "ami_id" {
    description = "ami id"
    type = string
    default = "ami-0984f4b9e98be44bf"
}


variable "instance_type" {
    description = "instance type"
    type = string
    default = "t2.micro"
}

variable "key_pair" {
  type = string     
  description = "key pair for ssh connection"
  default = "key_file"  
} 