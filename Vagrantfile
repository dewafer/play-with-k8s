# -*- mode: ruby -*-
# # vi: set ft=ruby :

# Specify minimum Vagrant version and Vagrant API version
Vagrant.require_version ">= 1.6.0"
VAGRANTFILE_API_VERSION = "2"

# Require YAML module
require 'yaml'

# Read YAML file with box details
servers = YAML.load_file('servers.yml')

# Create boxes
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Iterate through entries in YAML file
  servers.each do |server|
    # config.ssh.forward_agent = true
    config.vm.define server["name"] do |srv|
      srv.vm.box = server["box"]
      srv.vm.hostname = server["name"]
      srv.vm.network "private_network", ip: server["ip"]
      srv.vm.provider :virtualbox do |vb|
        vb.name = server["name"]
        vb.memory = server["ram"]
        vb.cpus = server["cpus"]
      end
      if server["ansible_host"]
        srv.vm.provision "kubernetes", type: :ansible_local, run: :never do |ansible|
          ansible.playbook = "kubernetes.yml"
          ansible.inventory_path = "inventory"
          ansible.limit = "all"
          # ansible.verbose = true
          ansible.galaxy_role_file = "requirements.yml"
          ansible.galaxy_roles_path = "/home/vagrant/.ansible/roles"
        end
        srv.vm.provision "file", source: "files/pks/id_rsa", destination: "/home/vagrant/.ssh/"
        srv.vm.provision "shell", inline: "chmod 600 /home/vagrant/.ssh/id_rsa"
      end
    end
  end
  config.vm.provision "shell" do |s|
    ssh_pub_key = File.readlines("files/pks/id_rsa.pub").first.strip
    s.inline = <<-SHELL
      echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys
      echo #{ssh_pub_key} >> /root/.ssh/authorized_keys
    SHELL
  end
  config.vm.provision "aliyun_mirror", type: :shell, path: "files/apply_aliyun_mirrors.sh", run: :never
end
