data "aws_subnet" "subnet_private_management" {
  id = var.subnet_private_management
}

resource "aws_instance" "ec2_management" { 
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id = data.aws_subnet.subnet_private_management.id
  vpc_security_group_ids = [aws_security_group.sg_private_EC2.id]
  iam_instance_profile = aws_iam_instance_profile.ec2-profile_private.name
  depends_on = [aws_instance.ec2_backend, aws_instance.ec2_frontend]
  key_name = var.key_pair
  tags = {
    Name = "ec2_management"
  }
user_data = file("${path.module}/ansible_install.sh")
#user_data = <<-EOF
#sudo yum update -y
#sudo yum install -y python3 
#sudo yum install -y pip 
#sudo pip install ansible
#sudo mkdir /etc/ansible
#sudo touch /etc/ansible/inventory.yml
#sudo touch /etc/ansible/playbook.yml
#sudo chmod 777 /etc/ansible/inventory.yml /etc/ansible/playbook.yml
#EOF
}

