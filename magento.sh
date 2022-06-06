#!/bin/bash
# color coding.
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
cyan=`tput setaf 6`
reset=`tput sgr0`
bg=`tput setab 7`

# All Required Variables
db_user=root
db_password=webkul
email=john@doe.com

#Creating Database
echo "Creating Database..........."
echo "${cyan}Enter Your DataBase name I'll create your DB${reset}"
read db_name

# DB existance check
db_exists=$(mysql -u $db_user -p$db_password -e "SHOW DATABASES LIKE '"$db_name"';" | grep "$db_name" > /dev/null; echo "$?")
if [ $db_exists -eq 0 ];then
    echo "${red}${bg}A database with the name $db_name already exists${reset}"
    exit
else
     echo "${yellow}Creating database $db_name.${reset}"
fi

mysql -u $db_user -p$db_password -e "create database $db_name;"
echo "${green} Database $db_name created${reset}"
sleep 1

#Install Magento
echo "${yellow}Installing Magento...........${reset}"
composer create-project --repository-url=https://repo.magento.com/ magento/project-community-edition
sleep 1

#Rename donloaded folder name (change required)
echo "${cyan}Enter your magento name${reset}"
read magento_directory
echo "${yellow}Magento name is $magento_directory ${reset}"
mv project-community-edition $magento_directory

#Go inside your folder (change required)
cd $magento_directory

#Give permissions
echo "${yellow}Giving permissions........${reset}"
find . -type f -exec chmod 644 {} \;
find . -type d -exec chmod 755 {} \;

#Install Magento
echo "${yellow}Installing Magento........${reset}"
php bin/magento setup:install --base-url=http://localhost/$magento_directory/ --db-host=localhost --db-name=$db_name --db-user=$db_user --db-password=$db_password --admin-firstname=admin --admin-lastname=admin --admin-email=$email --admin-user=admin --admin-password=admin123 --language=en_US --currency=USD --timezone=America/Chicago --use-rewrites=1

#Installing sample data
echo "${yellow}Installing sample data and updating magento.......${reset}"
php bin/magento sampledata:deploy; php bin/magento setup:upgrade; php bin/magento setup:di:compile; php bin/magento setup:static-content:deploy; php bin/magento cache:clean; php bin/magento indexer:reindex; php bin/magento cache:flush

# User input to edit backend URL
echo "${cyan}Do you want to edit your backend url? yes/no${reset}"
read backend_url
if [ "$backend_url" = yes -o y -o Yes -o Y ]; then
    admin_url=$(grep -E "admin_+" app/etc/env.php)
    sed -i "s/$admin_url/'frontName' => 'admin',/g" app/etc/env.php
    echo "${green}Backend url has been set. Your Magento is ready to use now...) ${reset}"
else
    echo "${green}Your Magento is ready to use now...) ${reset}"
fi
