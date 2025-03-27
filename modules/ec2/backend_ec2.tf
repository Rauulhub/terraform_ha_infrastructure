data "aws_subnet" "subnet_private_a" {
  id = var.subnet_private_a
}

resource "aws_instance" "ec2_backend" { 
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id = data.aws_subnet.subnet_private_a.id
  vpc_security_group_ids = [aws_security_group.sg_private_EC2.id]
  iam_instance_profile = aws_iam_instance_profile.ec2-profile_private.name
  key_name = var.key_pair
  tags = {
    Name = "ec2_backend"
  }
user_data = <<-EOF
sudo apt-get update
sudo apt-get upgrade
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo apt-get install -y unzip
sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo unzip awscliv2.zip
sudo ./aws/install
sudo apt install mysql-client -y

EOF
}

#sudo yum update -y
#sudo yum install -y python3 
#sudo yum install -y pip 
#sudo pip install ansible
#curl -sL https://deb.nodesource.com/setup_20.x | sudo bash -
#sudo yum install -y nodejs
