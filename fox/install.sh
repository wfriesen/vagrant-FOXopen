#!/bin/bash

ORA_HOST_OR_IP=localhost
ORA_SERVICE=xe
ORA_PORT=1521
ORA_SYS_PW=manager

export ORA_HOST_OR_IP
export ORA_SERVICE
export ORA_PORT
export ORA_SYS_PW

pushd /home/vagrant/vagrant-ubuntu-oracle-xe/fox/CodeSource/FiviumScriptInstaller/linux
yes | bash FiviumScriptInstaller.sh
