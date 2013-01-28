# -*- mode: ruby -*-
# vi: set ft=ruby :

box = 'precise'
box_url = 'http://files.vagrantup.com/precise64.box'
puppet_agents = {:arrakis => "192.168.33.11"}

Vagrant::Config.run do |config|
  config.vm.define :master do |mconfig|
    mconfig.vm.box = box
   # mconfig.vm.box_url = box_url
    mconfig.vm.host_name = "puppetmaster.vagrant.lan"
    mconfig.vm.network :hostonly, "192.168.33.10"
    mconfig.vm.share_folder('up_files', '/tmp/vagrant-puppet/files', 'files/up_files')
    mconfig.vm.share_folder('up_modules', '/tmp/vagrant-puppet/up_modules', 'files/up_modules')
    mconfig.vm.share_folder('hiera', '/etc/puppet/hieradata', 'files/master/hiera')
    mconfig.vm.share_folder('modules', '/etc/puppet/modules', 'files/master/modules')
    mconfig.vm.share_folder('master_manifests', '/etc/puppet/manifests', 'files/master/manifests')
  
    mconfig.vm.customize ["modifyvm", :id, "--memory", 1024]

    mconfig.vm.provision :puppet do |puppet|
      puppet.options = ["--modulepath", "/tmp/vagrant-puppet/up_modules"]
      puppet.manifest_file = "master.pp"
    end
end
  puppet_agents.each do |agent,ip_address|
    config.vm.define agent do |mconfig|
      mconfig.vm.box = box
   #   mconfig.vm.box_url = box_url
      mconfig.vm.host_name = "#{agent.to_s}.vagrant.lan"
      mconfig.vm.share_folder('up_files', '/tmp/vagrant-puppet/files', 'files/up_files')
      mconfig.vm.share_folder('up_modules', '/tmp/vagrant-puppet/up_modules', 'files/up_modules')
      mconfig.vm.customize ["modifyvm", :id, "--memory", 512]
      mconfig.vm.network :hostonly, ip_address
      mconfig.vm.provision :puppet, :options => ["--modulepath", "/tmp/vagrant-puppet/up_modules"]
      
      mconfig.vm.provision :puppet_server do |puppet|
        puppet.puppet_server = "192.168.33.10"
        puppet.puppet_node = "#{agent.to_s}.vagrant.lan"
      end
    end
  end
end
