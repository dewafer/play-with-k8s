#!/bin/bash

echo "** 应用阿里云镜像..."

sudo sed -i "s/archive.ubuntu.com/mirrors.aliyun.com/g" /etc/apt/sources.list
sudo apt-get update


echo "** 安装 python-pip"

sudo apt-get -y install python-pip

echo "** 应用阿里云 pip 镜像..."
#pip config set global.index-url https://mirrors.aliyun.com/pypi/simple/
sudo touch /etc/pip.conf
sudo bash -c 'cat <<EOF > /etc/pip.conf
[global]
index-url = https://mirrors.aliyun.com/pypi/simple/

[install]
trusted-host=mirrors.aliyun.com
EOF'

echo "** 从阿里云镜像安装 Docker..."

# step 1: 安装必要的一些系统工具
sudo apt-get update
sudo apt-get -y install apt-transport-https ca-certificates curl software-properties-common
# step 2: 安装GPG证书
curl -fsSL https://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo apt-key add -
# Step 3: 写入软件源信息
DOCKER_APT_SRC="deb [arch=amd64] https://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable"
sudo add-apt-repository "$DOCKER_APT_SRC"
# Step 4: 更新并安装Docker-CE
sudo apt-get -y update
#sudo apt-get -y install docker-ce=5:18.09.9~3-0~ubuntu-bionic

#docker version

echo "** 从阿里云镜像安装 Kubernetes..."

sudo apt-get update 
sudo apt-get install -y apt-transport-https
curl https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | sudo apt-key add - 
KUBERNETES_APT_SRC="deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main"
sudo bash -c "cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
$KUBERNETES_APT_SRC
EOF"
sudo apt-get update
#sudo apt-get install -y kubelet kubeadm kubectl

echo "** Generate extra var file to override repo in kubernetes playbook..."
sudo bash -c "cat <<EOF >/vagrant/vars/tmp
---
docker_apt_ignore_key_error: true
docker_apt_repository: '$DOCKER_APT_SRC'
kubernetes_apt_ignore_key_error: true
kubernetes_apt_repository: '$KUBERNETES_APT_SRC'
kubernetes_kubeadm_init_extra_opts: '--image-repository registry.aliyuncs.com/google_containers'
EOF"

echo "** export EXTRA_VAR_FILE=/vagrant/vars/tmp"
sudo bash -c 'cat <<EOF >>/etc/environment
EXTRA_VAR_FILE=/vagrant/vars/tmp
EOF'

echo "** DONE."
