#!/bin/bash

# Update the sources list
sudo apt-get update -y

# upgrade any packages available
sudo apt-get upgrade -y


# install git
sudo apt-get install git -y

# install nodejs
curl -fsSL https://deb.nodesource.com/setup_17.x | sudo -E bash -
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs

# install express
sudo npm install express
sudo npm install mongoose
sudo npm install ejs

# install pm2
sudo npm install pm2 -g

sudo apt-get install nginx -y

# remove the old file and add our one
sudo rm /etc/nginx/sites-available/default
sudo cp /home/ubuntu/app/environment/app/nginx.default /etc/nginx/sites-available/default

# finally, restart the nginx service so the new config takes hold
sudo service nginx restart
sudo service nginx enable