variable "subnet_private_db" {
  type = string
  description = "subnet for db"
}
variable "subnet_private_db_ha" {
  type = string
  description = "subnet for db ha"
}
variable "vpc_id" {
  type = string
  description = "ID of VPC"
}