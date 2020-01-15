Play with k8s clusters
------

## Requirements

* [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
* [Virtualbox](https://www.virtualbox.org)
* [Vagrant](https://www.vagrantup.com)
* [Ansible](https://www.ansible.com)

**Please note that current version of Vagrant (2.2.6) only supports Virtualbox version up to 6.0.x, please do not install Virtualbox 6.1.**

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
