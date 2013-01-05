# Puppetverse

_A Little Puppet Open Source Ecosystem Using Vagrant, Borrowing from binford2k's [puppet-in-a-box](https://github.com/binford2k/puppet-in-a-box)_

Puppetverse provides a small, virtual Puppet lab you can deploy using [VirtualBox][] and [Vagrant][]. After installing VirtualBox and Vagrant, you can clone this repository, `cd` into its directory, and issue the command `vagrant up` to set up and provision a working puppet master (`master`) and two agents (`arrakis` and `caladan`).

It's o.k., but it's also just a few hours' work hacking on someone else's thing to suit my Debianesque proclivities.

## Setting Up

You need VirtualBox and Vagrant. 

### VirtualBox 

[VirtualBox][] is freely available virtualization software that provides the headless VMs Vagrant provisions. You can download it from <https://www.virtualbox.org/wiki/Downloads>. Once you have it installed, you won't need to do anything else with it. Vagrant will handle the rest. 

### Vagrant

[Vagrant][] is an open source tool that allows you to quickly stand up virtual environments and code that closely match production environments. You can download Vagrant from <http://downloads.vagrantup.com> and follow the [installation instructions][] on the Vagrant site. 

### Puppetverse

You can clone this project with the following command:

`git clone git://github.com/pdxmph/puppetverse.git`

## Running

`$ cd puppetverse`  
`$ vagrant up`

## Using

### Getting Around

If you don't customize anything, the following commands will log you in to each of the nodes:

- `$ vagrant ssh master`   
- `$ vagrant ssh caladan` 
- `$ vagrant ssh arrakis` 

Once you're logged in, passwordless `sudo` is available, e.g. 

`$ vagrant ssh caladan`  
`$ sudo puppet agent -t`

#### Halting vs. Destroying

- Done with your environment, but want to keep your changes and power down your VMs? `$ vagrant halt`
- Done with your environment, and want to destroy your changes and start fresh? `$ vagrant destroy`

Individual nodes can be halted or destroyed by entering their names after the `halt` or `destroy` arguments:

`$ vagrant halt arrakis`  
`$ vagrant destroy arrakis`

#### Changes to the Puppet Environment

For now, if you decide to change the `site.pp` manifest on the `master` node, you'll need to reprovision `master` for the puppet master running on it to register the change:

`$ vagrant provision master`

### Customizing

- __Networking__: The master is assigned the IP address 192.168.33.10. If you don't like this, or if it conflicts with your network settings, you'll need to change that in a few places: 
  - `files/puppet_master.conf`
  - `Vagrantfile`
  - `manifests/default.pp`
- __Host names__: By default, you get `master`, `caladan` and `arrakis`. You can change the agent names by editing the `puppet_agents` array in `Vagrantfile`.
- __Base Box__: The base box is an Ubuntu/Precise VM provided by the Vagrant project. You can change the base box by editing the `box` and `box_url` variables in `Vagrantfile`. 
- __RAM__: The master is configured to use 1024MB of RAM, the agents are configured to use 256MB of RAM. Look for `mconfig.vm.customize ["modifyvm", :id, "--memory", 1024]` in `Vagrantfile` to change this.

### Peculiarities 

A few things you might or might not want to attend to before using:

- puppetverse makes sure it has the Puppet apt repository set up and upon `vagrant up` it will make sure it has the very newest version of Puppet Open Source (running an `apt-get update` during the provisioning phase). If you peek into `/manifests/master.pp` and remove the `apt::source` and "update" `exec`, provisioning will speed up a little, but you'll get Puppet 2.7 (if you keep the default box, which is Ubuntu Precise). 
- puppetverse reflects my current interest in Hiera, so it's configured to put Hiera configuration data in Vagrant's `files/master/hiera` directory, where it's easier to work with in one place out in the host operating system.  It also symlinks  `/etc/puppet/hieradata/hiera.yaml` to `/etc/hiera.yaml`, removing the step of passing a `--configuration` argument to `hiera` if you're using it on the command line. 

## TODO

- Separate the "vagrant provisions" part from the "puppet master stands on its own hind legs" part and put the `/etc/puppet` tree in a mounted directory so it can be manipulated from outside the VM without having to reprovision.
- Do more with templates so it's easier to fiddle with the network address, host names, etc. 
- Make NFS mounts easier to use for the bits where all the nodes are spun up and independent of Vagrant's bootstrap/provision sequence. 


[VirtualBox]: http://virtualbox.com
[Vagrant]: http://vagrantup.com
[installation instructions]: http://docs.vagrantup.com/v1/docs/getting-started/index.html