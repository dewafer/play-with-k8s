#!/bin/bash

sudo sed -i "s/archive.ubuntu.com/mirrors.aliyun.com/g" /etc/apt/sources.list

sudo apt update

sudo apt install python-pip -y

#pip config set global.index-url https://mirrors.aliyun.com/pypi/simple/

sudo touch /etc/pip.conf

sudo bash -c 'cat <<EOF > /etc/pip.conf
[global]
index-url = https://mirrors.aliyun.com/pypi/simple/

[install]
trusted-host=mirrors.aliyun.com
EOF'

echo "DONE."
