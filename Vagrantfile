Vagrant.configure("2") do |config|
  config.vm.define "vm1" do |vm1|
    vm1.vm.box = "bento/ubuntu-22.04"
    vm1.vm.network "private_network", ip: "192.168.56.3"
    vm1.vm.hostname = "vm1"
    vm1.vm.provider "virtualbox" do |vb|
      vb.memory = 2048
      vb.cpus = 2
    end
    vm1.vm.provision "shell" do |s|
      ssh_pub_key = File.readlines("#{Dir.home}/.ssh/id_ed25519.pub").first.strip
      s.inline = <<-SHELL
        echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys
        echo #{ssh_pub_key} >> /root/.ssh/authorized_keys
      SHELL
    end
    vm1.vm.post_up_message = "vm1 is running"
  end

  config.vm.define "vm2" do |vm2|
    vm2.vm.box = "bento/ubuntu-22.04"
    vm2.vm.network "private_network", ip: "192.168.56.4"
    vm2.vm.hostname = "vm2"
    vm2.vm.provider "virtualbox" do |vb|
      vb.memory = 2048
      vb.cpus = 2
    end
    vm2.vm.provision "shell" do |s|
      ssh_pub_key = File.readlines("#{Dir.home}/.ssh/id_ed25519.pub").first.strip
      s.inline = <<-SHELL
        echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys
        echo #{ssh_pub_key} >> /root/.ssh/authorized_keys
      SHELL
    end
    vm2.vm.post_up_message = "vm2 is running"
  end

  config.vm.define "vm3" do |vm3|
    vm3.vm.box = "bento/ubuntu-22.04"
    vm3.vm.network "private_network", ip: "192.168.56.5"
    vm3.vm.hostname = "vm3"
    vm3.vm.provider "virtualbox" do |vb|
      vb.memory = 2048
      vb.cpus = 2
    end
    vm3.vm.provision "shell" do |s|
      ssh_pub_key = File.readlines("#{Dir.home}/.ssh/id_ed25519.pub").first.strip
      s.inline = <<-SHELL
        echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys
        echo #{ssh_pub_key} >> /root/.ssh/authorized_keys
      SHELL
    end
    vm3.vm.post_up_message = "vm3 is running"
  end
end
