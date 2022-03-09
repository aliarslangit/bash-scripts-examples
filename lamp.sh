#!/bin/bash

#Install Apache
sudo apt update
sudo apt install apache2 -y

#Allow apache from firewall
sudo ufw app list
sudo ufw allow in "Apache"
sudo ufw status

#Install mysql
sudo apt install mysql-server -y


#Install php
sudo apt install php libapache2-mod-php php-mysql -y

#Verify Installations
 php -v
 apache2 -v
 sudo mysql

