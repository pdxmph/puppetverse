# -*- mode: ruby -*-
# vi: set ft=ruby :

box = 'precise'
box_url = 'http://files.vagrantup.com/precise64.box'
puppet_agents = {:arrakis => "192.168.33.11", :caladan => "192.168.33.12"}

Vagrant::Config.run do |config|
  config.vm.define :master do |mconfig|
    mconfig.vm.box = box
    config.vm.box_url = "http://files.vagrantup.com/precise64.box"
    mconfig.vm.host_name = "puppetmaster.vagrant.lan"
    mconfig.vm.network :hostonly, "192.168.33.10"
    mconfig.vm.share_folder('modules', '/tmp/vagrant-puppet/modules', 'modules')
    mconfig.vm.share_folder('files', '/tmp/vagrant-puppet/files', 'files')
    mconfig.vm.customize ["modifyvm", :id, "--memory", 1024]

    mconfig.vm.provision :puppet do |puppet|
      puppet.options = ["--modulepath", "/tmp/vagrant-puppet/modules"]
      puppet.manifest_file = "master.pp"
    end
end
  puppet_agents.each do |agent,ip_address|
    config.vm.define agent do |mconfig|
      mconfig.vm.box = box
      config.vm.box_url = "http://files.vagrantup.com/precise64.box"
      mconfig.vm.host_name = "#{agent.to_s}.vagrant.lan"
      mconfig.vm.provision :puppet, :options => ["--modulepath", "/tmp/vagrant-puppet/modules"]
      mconfig.vm.share_folder('modules', '/tmp/vagrant-puppet/modules', 'modules')
      mconfig.vm.share_folder('files', '/tmp/vagrant-puppet/files', 'files')
      mconfig.vm.customize ["modifyvm", :id, "--memory", 512]
      mconfig.vm.network :hostonly, ip_address
      mconfig.vm.provision :puppet_server do |puppet|
        puppet.puppet_server = "192.168.33.10"
        puppet.puppet_node = "#{agent.to_s}.vagrant.lan"
      end
    end
  end
end
