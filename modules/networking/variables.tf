variable "vpc_name" {
    description = "lab-vpc"
    type = string
}

variable "vpc_cidr" {
    description = "vpc cidr"
    type = string
}

variable "vpc_az" {
    description = "availability zones"
    type = list(string)
}

variable "vpc_public_subnet" {
    description = "public subnet frontend"
    type = list(string)
}

variable "vpc_private_subnet" {
    description = "private subnets backend and management"
    type = list(string)
}

variable "vpc_db_subnet" {
  description = "db subnets"
  type = list(string)
}
