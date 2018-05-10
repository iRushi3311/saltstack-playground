#!/bin/bash
set -x

if [ -e /etc/redhat-release ] ; then
  REDHAT_BASED=true
fi

# salt master
if [ ${REDHAT_BASED} ] ; then
    yum -y update
    yum -y install https://repo.saltstack.com/yum/redhat/salt-repo-latest-2.el7.noarch.rpm
    yum -y install salt-master salt-api
else 
    wget -O - https://repo.saltstack.com/apt/ubuntu/14.04/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -
    sudo su -; echo "deb http://repo.saltstack.com/apt/ubuntu/14.04/amd64/latest trusty main" >> /etc/apt/sources.list.d/saltstack.list; exit;
    sudo apt-get update
    sudo apt-get -y install salt-master salt-api
fi

# clean up
if [ ! ${REDHAT_BASED} ] ; then
  apt-get clean
fi