#!/bin/bash

source Components/common.sh

echo -e "\e[34mInstalling NGINX package\e[0m"
yum install nginx -y
check $?
echo -e "\e[34mEnable NGINX service\e[0m"
systemctl enable nginx
check $?
echo -e "\e[34mSTART NGINX Service\e[0m"
systemctl start nginx
check $?
echo -e "\e[34mDownload the frontend content\e[0m"
curl -f -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"
chec $?
echo -e "\e[34mmanage the content\e[0m"
cd /usr/share/nginx/html
rm -rf *
unzip /tmp/frontend.zip && mv frontend-main/* . && mv static/* .
check $?
echo -e "\e[34mcopy config file\e[0m"
mv localhost.conf /etc/nginx/default.d/roboshop.conf
check $?
echo -e "\e[34mrestrat NGINX service\e[0m"
systemctl restart nginx
check $?