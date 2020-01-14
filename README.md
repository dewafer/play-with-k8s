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
> ansible-playbook -i inventory playbook.yml
```

4. Connect to k8s cluster using config
On local machine:
```
> export KUBECONFIG=kubeconf/k8s-master-01_admin.conf
> kubectl get nodes
```
