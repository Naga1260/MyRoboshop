#!/bin/bash

USER_ID=$(id -u)
if [ $USER_ID -ne 0]; then
  echo "run the script with sudo"
  exit 1
fi

Check(){
  if [ $1 -eq 0 ]; then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[31mFAILURE\e[0m"
    exit 2
  fi
}

echo Installing NGINX package
yum install nginx -y
check()
echo Enable NGINX service
systemctl enable nginx
check()
echo START NGINX Service
systemctl start nginx
check()
echo Download the frontend content
curl -f -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"
chec()
echo manage the content
cd /usr/share/nginx/html
rm -rf *
unzip /tmp/frontend.zip && mv frontend-main/* . && mv static/* .
check()
echo copy config file
mv localhost.conf /etc/nginx/default.d/roboshop.conf
check()
echo restrat NGINX service
systemctl restart nginx
check()