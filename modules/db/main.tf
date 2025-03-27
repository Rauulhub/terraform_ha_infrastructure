data "aws_subnet" "subnet_private_db" {
    id = var.subnet_private_db
}
data "aws_subnet" "subnet_private_db_ha" {
    id = var.subnet_private_db_ha
}
resource "aws_db_subnet_group" "lab_rds_subnet_group" {
  name       = "lab-rds-subnet-group"
  subnet_ids = [data.aws_subnet.subnet_private_db.id, data.aws_subnet.subnet_private_db_ha.id]

  tags = {
    Name = "lab-rds-subnet-group"
  }
}
resource "aws_db_instance" "lab_rds" {
  allocated_storage    = 10
  db_name              = "movie_db"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "applicationuser"
  password             = "<yourpasswd>"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  publicly_accessible     = false
  vpc_security_group_ids = [aws_security_group.sg_private_rds.id]
  db_subnet_group_name    = aws_db_subnet_group.lab_rds_subnet_group.name
  availability_zone       = "us-east-1a"
  
  
}


