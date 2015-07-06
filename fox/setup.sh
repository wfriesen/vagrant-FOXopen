#!/bin/bash

echo "Configuring FOXopen"
if [ -d /usr/share/tomcat7/.fox ]
then
  echo "Removing existing .fox directory"
  rm -rf /usr/share/tomcat7/.fox
fi

echo "Creating .fox directory"
mkdir -p /usr/share/tomcat7/.fox

echo "Setting permissions on .fox"
chmod 777 /usr/share/tomcat7/.fox

echo "Restarting Tomcat"
service tomcat7 restart

apt-get -y install python-pip

pip install requests
pip install beautifulsoup4

python /home/vagrant/vagrant-ubuntu-oracle-xe/fox/setup.py
