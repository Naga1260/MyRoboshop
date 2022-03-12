
if [ id -u != 0]; then
  echo run the script with sudo
fi

yum install nginx -y
if [echo $? == 0]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE\e[0m"
  exit 2
systemctl enable nginx
if [echo $? == 0]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE\e[0m"
  exit 2
systemctl start nginx
if [echo $? == 0]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE\e[0m"
   exit 2

curl -f -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"
if [ echo $? == 0]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE\e[0m"
  exit 2

cd /usr/share/nginx/html
rm -rf *
unzip /tmp/frontend.zip && mv frontend-main/* . && mv static/* .
if [ echo $? == 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE\e[0m"
  exit 2
mv localhost.conf /etc/nginx/default.d/roboshop.conf
if [ echo $? == 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE\e[0m"
  exit 2
systemctl restart nginx
if [echo $? == 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE\e[0m"
  exit 2