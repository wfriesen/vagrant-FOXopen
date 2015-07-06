#!/bin/bash

ORA_HOST_OR_IP=localhost
ORA_SERVICE=xe
ORA_PORT=1521
ORA_SYS_PW=manager

export ORA_HOST_OR_IP
export ORA_SERVICE
export ORA_PORT
export ORA_SYS_PW

if [ -f /home/vagrant/vagrant-ubuntu-oracle-xe/fox/CodeSource/FiviumScriptInstaller/linux/FiviumScriptInstaller.sh ]
then
  echo "Deploying FOXopen application"

  if [ -d /home/vagrant/vagrant-ubuntu-oracle-xe/fox/CodeSource/DatabasePatches/CorePatches/UtilsForReleaseDirectoryLinux ]
  then
    echo "Removing existing UtilsForReleaseDirectoryLinux"
    rm -rf /home/vagrant/vagrant-ubuntu-oracle-xe/fox/CodeSource/DatabasePatches/CorePatches/UtilsForReleaseDirectoryLinux
  fi

  echo "Generating UtilsForReleaseDirectoryLinux"
  cp -r /home/vagrant/vagrant-ubuntu-oracle-xe/fox/CodeSource/DatabasePatches/CorePatches/UtilsForReleaseDirectory /home/vagrant/vagrant-ubuntu-oracle-xe/fox/CodeSource/DatabasePatches/CorePatches/UtilsForReleaseDirectoryLinux

  # These files won't be run, so don't keep a copy here.
  rm /home/vagrant/vagrant-ubuntu-oracle-xe/fox/CodeSource/DatabasePatches/CorePatches/UtilsForReleaseDirectoryLinux/PRE_RUN_OPTION*.sql

  sed -i 's/UtilsForReleaseDirectory/UtilsForReleaseDirectoryLinux/g' /home/vagrant/vagrant-ubuntu-oracle-xe/fox/CodeSource/DatabasePatches/CorePatches/UtilsForReleaseDirectoryLinux/*.sql
  sed -i 's/\\/\//g' /home/vagrant/vagrant-ubuntu-oracle-xe/fox/CodeSource/DatabasePatches/CorePatches/UtilsForReleaseDirectoryLinux/*.sql

  if [ -f /home/vagrant/vagrant-ubuntu-oracle-xe/fox/CodeSource/FoxResourceMaster/* ]
  then
    echo "Removing resource_master files"
    rm /home/vagrant/vagrant-ubuntu-oracle-xe/fox/CodeSource/FoxResourceMaster/*
  fi

  echo "Adding default resource_master"
  cp /home/vagrant/vagrant-ubuntu-oracle-xe/fox/resource_master.xml /home/vagrant/vagrant-ubuntu-oracle-xe/fox/CodeSource/FoxResourceMaster

  pushd /home/vagrant/vagrant-ubuntu-oracle-xe/fox/CodeSource/FiviumScriptInstaller/linux
  yes | bash FiviumScriptInstaller.sh --force-reset
else
  echo "Cannot find /home/vagrant/vagrant-ubuntu-oracle-xe/fox/CodeSource/FiviumScriptInstaller/linux/FiviumScriptInstaller.sh"
  echo "Not deploying FOXopen application"
fi
