#!/bin/bash

source Components/common.sh

echo this is Mongodb
echo -e "\e[34mDownloading files\e[0m"
curl -f -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/roboshop-devops-project/mongodb/main/mongo.repo
check $?

echo -e "\e[34mInstall MongoDB\e[0m"
yum install -y mongodb-org
check $?

echo -e "\e[34mEnable MongoDB Service\e[0m"
systemctl enable mongod
check $?
echo -e "\e[34mStart MongoDB service\e[0m"
systemctl start mongod
check $?

echo -e "\e[34mUpdate mongodb listen address\e[0m"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
check $?
echo -e "\e[34mRestart MongoDB service\e[0m"
systemctl restart mongod
check $?
echo -e "\e[34mDownloading mongodb  content\e[0m"
curl -f -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip"
check $?


echo -e "\e[34mmove the content\e[0m"
cd /tmp && unzip mongodb.zip && cd mongodb-main
check $?
echo -e "\e[34mupdate database\e[0m"
mongo < catalogue.js
mongo < users.js
check $?