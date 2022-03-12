#!/bin/bash

echo this is USER

print "change user to roboshop"
su - roboshop
check $?

print "download the catalogue"
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip"
check $?

print "move the content and unzip"
cd /home/roboshop &>>LOG_FILE && unzip /tmp/catalogue.zip &>>LOG_FILE && mv catalogue-main catalogue &>>LOG_FILE && cd /home/roboshop/catalogue &>>LOG_FILE
check $?

print "install npm"
npm install &>>LOG_FILE
check $?


check $?
print "Updte Mongo_dns"
sed -i -e 's/MONGO_DNSNAME/172.31.83.93/' /home/roboshop/catalogue/systemd.service
check $?