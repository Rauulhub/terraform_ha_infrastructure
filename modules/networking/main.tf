#VPC creation
resource "aws_vpc" "lab_vpc" {
  cidr_block =  var.vpc_cidr
  tags = {
    Name = "lab_vpc"
  }
}
#subnets
resource "aws_subnet" "subnet_public_a" {
  vpc_id     = aws_vpc.lab_vpc.id
  cidr_block = var.vpc_public_subnet[0]
  availability_zone = var.vpc_az[0]
  tags = {
    Name = "subnet_public az-a"
  }
}
resource "aws_subnet" "subnet_public_b" {
  vpc_id     = aws_vpc.lab_vpc.id
  cidr_block = var.vpc_public_subnet[1]
  availability_zone = var.vpc_az[1]
  tags = {
    Name = "subnet_public az-b"
  }
}
resource "aws_subnet" "subnet_private_management" {
  vpc_id     = aws_vpc.lab_vpc.id
  cidr_block = var.vpc_private_subnet[0]
  availability_zone = var.vpc_az[0]
  tags = {
    Name = "subnet_private_management"
  }
}
resource "aws_subnet" "subnet_private_a" {
  vpc_id     = aws_vpc.lab_vpc.id
  cidr_block = var.vpc_private_subnet[1]
  availability_zone = var.vpc_az[0]
  tags = {
    Name = "subnet_private_a"
  }
}
resource "aws_subnet" "subnet_private_b" {
  vpc_id     = aws_vpc.lab_vpc.id
  cidr_block = var.vpc_private_subnet[2]
  availability_zone = var.vpc_az[1]
  tags = {
    Name = "subnet_private_b"
  }
}
resource "aws_subnet" "subnet_private_db" {
  vpc_id     = aws_vpc.lab_vpc.id
  cidr_block = var.vpc_db_subnet[0]
  availability_zone = var.vpc_az[0]
  tags = {
    Name = "subnet_private db"
  }
}

resource "aws_subnet" "subnet_private_db_ha" {
  vpc_id     = aws_vpc.lab_vpc.id
  cidr_block = var.vpc_db_subnet[1]
  availability_zone = var.vpc_az[1]
  tags = {
    Name = "subnet_private db ha"
  }
}

#internet GW
resource "aws_internet_gateway" "lab_internet_gw" {
  vpc_id = aws_vpc.lab_vpc.id
  tags = {
    Name = "lab_internet_gw"
  }
}
resource "aws_route_table" "internet" {
  vpc_id = aws_vpc.lab_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lab_internet_gw.id
  }
  tags = {
    Name = "internet"
  }
}
resource "aws_route_table_association" "public_routetable" {
  subnet_id      = aws_subnet.subnet_public_a.id
  route_table_id = aws_route_table.internet.id
}

#Nat GW
resource "aws_eip" "nat_eip" {
  tags = {
    name = "elasticIP_Nat"
  }
}
resource "aws_nat_gateway" "lab_natgw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.subnet_public_a.id
  depends_on = [aws_internet_gateway.lab_internet_gw]
}
resource "aws_route_table" "nat" {
  vpc_id = aws_vpc.lab_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.lab_natgw.id
  }
  tags = {
    Name = "nat"
  }
}
resource "aws_route_table_association" "private_routetable" {
  subnet_id      = aws_subnet.subnet_private_a.id
  route_table_id = aws_route_table.nat.id
}
resource "aws_route_table_association" "private_routetable_db" {
  subnet_id      = aws_subnet.subnet_private_db.id
  route_table_id = aws_route_table.nat.id
}
resource "aws_route_table_association" "public_routetable_management" {
  subnet_id      =  aws_subnet.subnet_private_management.id
  route_table_id = aws_route_table.nat.id
}
