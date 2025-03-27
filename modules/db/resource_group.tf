data "aws_vpc" "lab_vpc" {
  id = var.vpc_id
}

#security group for private db
resource "aws_security_group" "sg_private_rds" {
  name        = "sg_private_rds"
  description = "Allow  inbound traffic from ec2"
  vpc_id      = data.aws_vpc.lab_vpc.id
  egress {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
    }
  ingress{
    protocol = "tcp"
    from_port =3306
    to_port =3306
    cidr_blocks = ["10.1.0.32/28"]
  }
}