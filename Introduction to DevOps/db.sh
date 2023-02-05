#!/bin/bash

echo "* Add hosts ..."
echo "192.168.89.100 web.do1.lab web" >> /etc/hosts
echo "192.168.89.101 db.do1.lab db" >> /etc/hosts

echo "* Install Software ..."
sudo apt update && sudo apt upgrade -y
sudo apt install mariadb-server -y

echo "* Start HTTP ..."
sudo systemctl start mariadb.service
sudo systemctl enable mariadb.service

sudo sed -i.bak s/127.0.0.1/0.0.0.0/g /etc/mysql/mariadb.conf.d/50-server.cnf
sudo systemctl restart mariadb.service

echo "* Create and load the database ..."
sudo mariadb -u root < /vagrant/db_setup.sql