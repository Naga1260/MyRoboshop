
if [ id -u != 0]; then
  echo run the script with sudo
fi


yum install nginx -y
echo $?
systemctl enable nginx
echo $?
systemctl start nginx
echo$?

curl -f -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"
echo $?
cd /usr/share/nginx/html
rm -rf *
unzip /tmp/frontend.zip
mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.md
echo $?
mv localhost.conf /etc/nginx/default.d/roboshop.conf
echo$?
systemctl restart nginx
echo $?