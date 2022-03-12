#!/bin/bash

source Components/common.sh

echo this is Mongodb
print "Downloading files"
curl -f -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/roboshop-devops-project/mongodb/main/mongo.repo
check $?

print "Install MongoDB"
yum install -y mongodb-org $>>LOG_FILE
check $?

print "Enable MongoDB Service"
systemctl enable mongod $>>LOG_FILE
check $?

print "Start MongoDB service"
systemctl start mongod $>>LOG_FILE
check $?

print "Update mongodb listen address"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
check $?

print "Restart MongoDB service"
systemctl restart mongod $>>LOG_FILE
check $?

print "Downloading mongodb  content"
curl -f -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip" $>>LOG_FILE
check $?

print "move the content"
cd /tmp $>>LOG_FILE && unzip mongodb.zip $>>LOG_FILE && cd mongodb-main $>>LOG_FILE
check $?
print "update database"
mongo < catalogue.js
mongo < users.js
check $?