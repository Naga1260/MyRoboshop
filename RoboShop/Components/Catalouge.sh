#!/bin/bash

source Components/common.sh

echo this is Catalouge

curl -fsSL https://rpm.nodesource.com/setup_lts.x | bash -
check $?
yum install nodejs gcc-c++ -y
check $?
useradd roboshop

curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip"
cd /home/roboshop
unzip /tmp/catalogue.zip
mv catalogue-main catalogue
cd /home/roboshop/catalogue
npm install


mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
systemctl daemon-reload
systemctl start catalogue
systemctl enable catalogue