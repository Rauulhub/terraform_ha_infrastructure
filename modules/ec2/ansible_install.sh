#!/bin/bash
# Actualizar paquetes e instalar dependencias
sudo add-apt-repository universe
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install -y python3-pip
sudo pip3 install ansible
sudo mkdir /etc/ansible
sudo touch /etc/ansible/inventory.yml
sudo touch /etc/ansible/playbook.yml
sudo chmod 777 /etc/ansible/inventory.yml /etc/ansible/playbook.yml

sudo tee /etc/ansible/inventory.yml > /dev/null << EOF
all: 
  children:
    webservers:
      hosts:
        frontend:
          ansible_host: 10.1.0.13
          ansible_user: ubuntu
          ansible_ssh_private_key_file: /tmp/key_file
        backend:
          ansible_host: 10.1.0.41
          ansible_user: ubuntu
          ansible_ssh_private_key_file: /tmp/key_file
EOF


sudo tee /etc/ansible/playbook.yml > /dev/null << EOF
---
- name: Configure Backend Instance
  hosts: backend
  become: yes
  tasks:
    - name: Update and install dependencies
      apt:
        name:
          - unzip
        state: present
        update_cache: yes
    - name: Create application directory
      file:
        path: /etc/backend
        state: directory
        mode: "0755"
    - name: Download application files from S3
      command: sudo aws s3 cp s3://lab-final-backend/backend.zip /etc/backend
    - name: Extract application files
      unarchive:
        src: /etc/backend/backend.zip
        dest: /etc/backend
        remote_src: yes
    - name: Install backend dependencies
      command: sudo npm install
      args:
        chdir: /etc/backend/
    - name: Start backend application
      command: sudo nohup npm run start
      args:
        chdir: /etc/backend/
      async: 60
      poll: 0
- name: Configure Frontend Instance
  hosts: frontend
  become: yes
  tasks:
    - name: Update and install dependencies
      apt:
        name:
          - unzip
        state: present
        update_cache: yes
    - name: Create application directory
      file:
        path: /etc/frontend
        state: directory
        mode: "0755"
    - name: Download application files from S3
      command: sudo aws s3 cp s3://lab-final-backend/frontend.zip /etc/frontend
    - name: Extract application files
      unarchive:
        src: /etc/frontend/frontend.zip
        dest: /etc/frontend
        remote_src: yes
    - name: Install frontend dependencies
      command: sudo npm install
      args:
        chdir: /etc/frontend
    - name: Start frontend application
      command: sudo nohup npm run start
      args:
        chdir: /etc/frontend
      async: 60
      poll: 0

EOF
#chmod 400 /tmp/key_file
#ssh -i /tmp/key_file ec2-user@ip
#ansible-playbook -i /etc/ansible/inventory.yml /etc/ansible/private-playbook.yml  
