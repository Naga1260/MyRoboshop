#!/bin/bash

source Components/common.sh

echo Installing NGINX package
yum install nginx -y
check $?
echo Enable NGINX service
systemctl enable nginx
check $?
echo START NGINX Service
systemctl start nginx
check $?
echo Download the frontend content
curl -f -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"
chec $?
echo manage the content
cd /usr/share/nginx/html
rm -rf *
unzip /tmp/frontend.zip && mv frontend-main/* . && mv static/* .
check $?
echo copy config file
mv localhost.conf /etc/nginx/default.d/roboshop.conf
check $?
echo restrat NGINX service
systemctl restart nginx
check $?