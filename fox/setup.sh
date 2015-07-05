#!/bin/bash

if [ -d /usr/share/tomcat7/.fox ]
then
  rm -rf /usr/share/tomcat7/.fox
fi

mkdir -p /usr/share/tomcat7/.fox
chmod 777 /usr/share/tomcat7/.fox

service tomcat7 restart

apt-get -y install python-pip

pip install requests
pip install beautifulsoup4

python /home/vagrant/vagrant-ubuntu-oracle-xe/fox/setup.py
