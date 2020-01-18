#!/bin/bash

echo "Apply Aliyun apt mirrors..."

sudo sed -i "s/archive.ubuntu.com/mirrors.aliyun.com/g" /etc/apt/sources.list
sudo apt-get update


echo "Install python-pip"

sudo apt-get -y install python-pip

echo "Apply Aliyun pip mirrors..."
#pip config set global.index-url https://mirrors.aliyun.com/pypi/simple/
sudo touch /etc/pip.conf
sudo bash -c 'cat <<EOF > /etc/pip.conf
[global]
index-url = https://mirrors.aliyun.com/pypi/simple/

[install]
trusted-host=mirrors.aliyun.com
EOF'

echo "Install docker from Aliyun mirrors..."

# step 1: 安装必要的一些系统工具
sudo apt-get update
sudo apt-get -y install apt-transport-https ca-certificates curl software-properties-common
# step 2: 安装GPG证书
curl -fsSL https://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo apt-key add -
# Step 3: 写入软件源信息
sudo add-apt-repository "deb [arch=amd64] https://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable"
# Step 4: 更新并安装Docker-CE
sudo apt-get -y update
sudo apt-get -y install docker-ce=5:18.09.9~3-0~ubuntu-bionic

docker version

echo "Install Kubernetes from Aliyun mirrors..."

sudo apt-get update 
sudo apt-get install -y apt-transport-https
curl https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | sudo apt-key add - 
sudo bash -c 'cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main
EOF'
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl

echo "DONE."
