#!/bin/bash

source Components/common.sh

print "Installing NGINX package"
yum install nginx -y &>>LOG_FILE
check $?
print "Enable NGINX service"
systemctl enable nginx &>>LOG_FILE
check $?
print "START NGINX Service"
systemctl start nginx &>>LOG_FILE
check $?
print "Download the frontend content"
curl -f -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" &>>LOG_FILE
check $?
print "manage the content"
cd /usr/share/nginx/html
rm -rf *
unzip /tmp/frontend.zip &>>LOG_FILE && mv frontend-main/* .  &>>LOG_FILE && mv static/* . &>>LOG_FILE
check $?
print "copy config file"
mv localhost.conf /etc/nginx/default.d/roboshop.conf
check $?
print "restrat NGINX service"
systemctl restart nginx &>>LOG_FILE
check $?