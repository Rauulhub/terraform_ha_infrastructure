# terraform_ha_infrastructure

![arch-actions drawio](https://github.com/user-attachments/assets/706f4b32-4e38-4135-81fb-0c6bd19c51e7)
Implementing the infrastructure of the picture, can implement also terraform workspaces updating the backend in S3
bucket automatically.
implementations:
* Aplication load balancer but can use classic load balancer
* Need to create S3 backend and dynamoDB for statelocking manually
* IAM role for accessing S3 bucket to get backend and frontend resources
* IAM role for Ec2 Access by SSM
* Pipeline with Github Actions
* Private Ec2 instances connteded to internet with Nat Gw
* Ansible for instances configuration with a bastion or management node
 
