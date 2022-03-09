#!/bin/bash

#Install Nginx
sudo apt update
sudo apt install nginx -y

#Allow Nginx from firewall
sudo ufw app list
sudo ufw allow 'Nginx HTTP'

#Verify Installation
systemctl status nginx

# curl http://localhost:80