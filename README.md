Play with k8s clusters
------

## Prerequisites

* [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
* [Virtualbox](https://www.virtualbox.org)
* [Vagrant](https://www.vagrantup.com)
* [Ansible](https://www.ansible.com) (Optional)

**Please note that current version of Vagrant (2.2.6) only supports Virtualbox version up to 6.0.x, please do not install Virtualbox 6.1.**

If you install Ansible on your host machine is not an option, please check *Windows User* section.

## Usage

1. Install requirements from Ansible Galaxy.
```bash
> ansible-galaxy install -r requirements.yml
```

2. Start Vms using Vagrant
```bash
> vagrant up
```

3. Install kubernetes clusters using Ansible playbook.
```bash
> ansible-playbook -i inventory kubernetes.yml
```

4. Connect to k8s cluster using config
```bash
> export KUBECONFIG=kubeconf/k8s-master-01_admin.conf
> kubectl get nodes
```

5. Copy the granted token from generated dashboard_token.log
```bash
cat dashboard_token.log | grep '^token'
```

6. Run proxy for the Dashboard
```bash
> kubectl proxy
```

7. Open the Dashboard UI and login using the token.
[http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/](http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/)



## Others

### Install Dashboard Only

```bash
> ansible-playbook -i inventory dashboard.yml
```

### Regenerate dashboard token

```bash
> ansible-playbook -i inventory dashboard_token.yml
```


## Windows User

Because Ansible does not support Windows host, we can use one of the nodes of the k8s clusters as the Ansible host.
I've configured Vagrant to provision the kubernetes using the master node as the Ansible host.
So please use the following orders to startup the clusters.

1. Start Vms using Vagrant
```cmd
> vagrant up
```

2. Provision kuberneters using Vagrant provision.
```cmd
> vagrant provision --provision-with kubernetes
```

3. Use your k8s clusters.

4. You can also run Ansible playbook after ssh into the master node, the project folder will be automatically mounted to `/vagrant`, and Ansible should already be installed.
```cmd
> vagrant ssh k8s-master-01
> cd /vagrant
> ansible-playbook -i inventory dashboard_token.yml
```

## Memo for myself

* If you can not connect to k8s-master-01, add router for interface `vboxnet1` of virtualbox:
```bash
> sudo route add -net 192.168.10 -interface vboxnet1
# check route
> netstat -nr
```


# 中文安装指南

## 事先安装

* [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) (可不装)
* [Virtualbox](https://www.virtualbox.org)（注意请安装**6.0.x**的版本！）
* [Vagrant](https://www.vagrantup.com)
* [Ansible](https://www.ansible.com) （可不装，不支持Windows）

**注意1：当前 Vagrant 版本（2.2.6）不支持 Virtualbox 6.1，请安装6.0.x版本的 VirtualBox**

**注意2：Ansible 不支持使用 Windows 做主机，如果你是 Windows 用户，可以不用装，当然你是 Macos 或者 Linux 用户也可以不用装，我都帮你们在 Vagrant Provision 里配置好了。**

## 安装步骤

1. 使用 Vagrant 起虚拟机：
```bash
> vagrant up
```

2. 国内网络环境用户、不能科学上网的国内用户，我特地为大家准备了使用阿里云镜像的加速；如果你能科学上网或者身处国外网络环境，请跳过此步骤：
```bash
> vagrant provision --provision-with aliyun_mirror
```

3. 安装 Kubernetes
```bash
> vagrant provision --provision-with kubernetes
```

4. 狗定，大家都是资深开发/运维人员了，自己研究吧。

## 常见问题

### 国内网络环境 / 非科学上网环境 `vagrant up` 慢、超时报错等

1. 使用此链接下载ubuntu的box
```
https://vagrantcloud.com/ubuntu/boxes/bionic64/versions/20200115.0.0/providers/virtualbox.box
```

2. 将下载的box添加到本地 Vagrant box ，记得自行替换路径
```bash
> vagrant box add --name ubuntu/bionic64 C:\\迅雷下载\\virtualbox.box
```
