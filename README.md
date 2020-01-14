Play with k8s clusters
------

## Requirements

* kubectl
* Virtualbox
* Vagrant
* Ansible

## Usage

1. Install requirements from Ansible Galaxy.
```
> ansible-galaxy install -r requirements.yml
```

2. Start Vms using Vagrant
```
> vagrant up
```

3. Install kubernetes clusters using Ansible playbook.
```
> ansible-playbook -i inventory --ssh-extra-args="-o StrictHostKeyChecking=no" -v playbook.yml
```

4. Copy admin.conf out and connect
```
> vagrant ssh k8s-master-01
> sudo cp /etc/kubernetes/admin.conf /vagrant/
> exit
```
On local machine:
```
> export KUBECONF=admin.conf
> kubectl get nodes
```
