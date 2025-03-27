data "aws_subnet" "subnet_public_a" {
  id = var.subnet_public_a
}
resource "aws_instance" "ec2_frontend" { 
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id = data.aws_subnet.subnet_public_a.id
  vpc_security_group_ids = [aws_security_group.sg_public_EC2.id]
  associate_public_ip_address = true
  iam_instance_profile = aws_iam_instance_profile.ec2-profile_private.name
  key_name = var.key_pair
  tags = {
    Name = "ec2_frontend"
  }
user_data = <<-EOF
sudo apt-get update
sudo apt-get upgrade
sudo curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo apt-get install -y unzip
sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo unzip awscliv2.zip
sudo ./aws/install --update
EOF
}

#sudo yum update -y
#sudo yum install -y python3 
#sudo yum install -y pip 
#sudo pip install ansible
#curl -sL https://rpm.nodesource.com/setup_16.x | sudo bash -
#sudo yum install -y nodejs