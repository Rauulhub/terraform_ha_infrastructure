data "aws_vpc" "lab_vpc" {
  id = var.vpc_id
}
#security group for application load balancer
resource "aws_security_group" "sg_clb" {
  name        = "sg_clb"
  description = "Allow  inbound traffic and all outbound traffic"
  vpc_id      = data.aws_vpc.lab_vpc.id
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  
  ingress{
    protocol = "tcp"
    from_port =80
    to_port =80
    cidr_blocks = ["0.0.0.0/0"] 
  }
}
#security group for private Ec2
resource "aws_security_group" "sg_private_EC2" {
  name        = "sg_private_EC2"
  description = "Allow  inbound traffic and all outbound traffic"
  vpc_id      = data.aws_vpc.lab_vpc.id
  egress {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
    }
  ingress{
    protocol = "-1"
    from_port =0
    to_port =0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress{
    protocol = "-1"
    from_port =0
    to_port =0
    cidr_blocks = ["0.0.0.0/0"]
  }
  #ingress {
  #protocol = "tcp"
  #from_port = 3000
  #to_port = 3000
  #security_groups = [aws_security_group.sg_clb.id]
  #}
}
#security group for public Ec2
resource "aws_security_group" "sg_public_EC2" {
  name        = "sg_public_EC2"
  description = "Allow  inbound traffic and all outbound traffic"
  vpc_id      = data.aws_vpc.lab_vpc.id
  egress {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
    }
  ingress{
    protocol = "-1"
    from_port =0
    to_port =0
    cidr_blocks = ["0.0.0.0/0"]
  }
  #ingress{
  #  protocol = "tcp"
  #  from_port =80
  #  to_port =80
  #  cidr_blocks = ["0.0.0.0/0"] 
  #}
}