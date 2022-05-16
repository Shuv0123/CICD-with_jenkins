#!/bin/bash

#install linux
sudo apt update -y

sudo apt upgrade -y

#install and enable nginx
#sudo apt install nginx -y

#sudo systemctl start nginx

#sudo systemctl enable nginx

#install nodejs
#sudo apt install python-software-properties -y

curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -

sudo apt install -y nodejs

#npm
cd  /app/app

npm install

npm  start &

