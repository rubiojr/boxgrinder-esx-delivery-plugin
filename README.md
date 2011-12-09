# Boxgrinder ESX Delivery Plugin 

Deliver appliances to VMWare ESX hypervisors 

# Pre-requisites

* Boxgrinder
* VMWare ESX/ESXi hypervisor with SSH service enabled

# Install 

    $ gem install --no-ri --no-rdoc boxgrinder-esx-delivery-plugin

# Usage
    
    $ boxgrinder-build -l esx-delivery-plugin \
                       -p vmware --platform-config type:personal,thin_disk:true \
                       -d esx --delivery-config esx_host:esx-test-host,esx_user:root,esx_password:secret \
                       my-appliance.appl

Boxgrinder will build the appliance, convert the appliance disk image to
a suitable VMDK variant and the resulting VMDK will be uploaded to the ESX host via SSH
and used to creat a virtual machine in that ESX host.


#ESX delivery plugin configuration parameters

The ESX Boxgrinder delivery plugin accepts the following list of config parameters:

**esx_host:** the ESX hostname/ipaddress. Default is 127.0.0.1.

**esx_user:** the ESX user to use. Default is root.

**esx_password:** the ESX password to use. Default is secret.

**datastore:** the ESX datastore to use. Default is datastore1.

**name:** the target virtual machine name. Default is Virtual Appliance name.

**memory:** the amount of RAM the appliance will have. Default is 512 MB.

**cpu:** the number of CPUs the appliance will have. Default 1.

All the config parameters have default values. Use the **--delivery-config** Boxgrinder parameter to configure the appliance upload to fit your needs.

Make sure you define at lease **esx_host, esx_user and esx_password** parametes to fit your needs.

# Copyright

Copyright (c) 2011 Sergio Rubio. See LICENSE.txt for
further details.

