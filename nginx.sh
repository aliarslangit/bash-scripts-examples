sudo apt update
sudo apt install nginx -y

sudo ufw app list

sudo ufw allow 'Nginx HTTP'

systemctl status nginx

