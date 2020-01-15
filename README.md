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
> ansible-playbook -i inventory kubernetes.yml
```

4. Connect to k8s cluster using config
```
> export KUBECONFIG=kubeconf/k8s-master-01_admin.conf
> kubectl get nodes
```

5. Copy the granted token from generated dashboard_token.log
```
cat dashboard_token.log | grep '^token'
```

6. Run proxy for the Dashboard
```
> kubectl proxy
```

7. Open the Dashboard UI and login using the token.
[http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/](http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/)



## Others

### Install Dashboard Only

```
> ansible-playbook -i inventory dashboard.yml
```

### Regenerate dashboard token

```
> ansible-playbook -i inventory dashboard_token.yml
```
