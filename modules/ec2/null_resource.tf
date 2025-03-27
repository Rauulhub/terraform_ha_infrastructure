#resource "null_resource" "name" {
#
#  # used to connect the local laptop to the EC2 instance  
#  connection {
#    type     = "ssh"
#    user     = "ec2-user"
#    host     = aws_instance.ec2_management.public_ip
#    private_key = file("${path.module}/key_file.pem")
#  }
#
#  # File provisioner to push the .pem file to Bastion EC2 instance
#  provisioner "file" {
#    source = "private_file.pem"
#    destination = "/tmp/private_file.pem"
#  }
#
#  # Remote-exec is used to provide executable permission via below command
#  provisioner "remote-exec" {
#    inline = ["sudo chmod 400 /tmp/private_file.pem"]
#  }
#
#}