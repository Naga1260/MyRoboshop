#!/bin/bash

source Components/common.sh

echo this is Catalouge

print "download nodejs"
curl -fsSL https://rpm.nodesource.com/setup_lts.x | bash -  &>>LOG_FILE
check $?

print "install nodejs"
yum install nodejs gcc-c++ -y  &>>LOG_FILE
check $?

print "create a roboshop user"
id -u roboshop
if [ "$?" -eq 0 ]; then
  echo -e "\e[31mUser existed\e[0m"
else
  useradd roboshop
fi
check $?

print "change user to roboshop"



print "download the catalogue"
sudo su - roboshop && curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip"


print "move the content and unzip"
cd /home/roboshop &>>LOG_FILE
unzip /tmp/catalogue.zip &>>LOG_FILE
mv catalogue-main catalogue &>>LOG_FILE
cd /home/roboshop/catalogue &>>LOG_FILE
check $?

print "install npm"
npm install &>>LOG_FILE
check $?

print "Update Mongo_dns"
sed -i -e 's/MONGO_DNSNAME/172.31.83.93/' /home/roboshop/catalogue/systemd.service
check $?

print "update the catalogue config to systemd"
mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
systemctl daemon-reload &>>LOG_FILE && systemctl start catalogue &>>LOG_FILE && systemctl enable catalogue &>>LOG_FILE
check $?