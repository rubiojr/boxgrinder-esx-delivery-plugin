# Boxgrinder ESX Delivery Plugin 

Using Boxgrinder to build and upload appliances to VMWare ESX hypervisors 

This tutorial will guide you to create an Ubuntu Oneiric appliance using [Boxgrinder](http://boxgrinder.org) and deliver the appliance to the ESX hypervisor.

# Pre-requisites

You need an Ubuntu based Boxgrinder meta-appliance (used to build other appliances). Get it from:

    http://download.frameos.org/appliances/boxgrinder-meta-ubuntu-oneiric-amd64.vmdk

and deploy it.

# Install the Boxgrinder boxgrinder-esx-delivery-plugin to the meta-appliance

SSH to the boxgrinder meta-appliance. Default password for the root user is 'boxgrinder'.

    $ ssh root@my-boxgrinder-meta-app

Install required packages:

    $ apt-get install libcurl4-openssl-dev build-essential git

Install the plugin

    $ gem install --no-ri --no-rdoc boxgrinder-esx-delivery-plugin

# Download sample appliance definitions

You can download some Ubuntu based Boxgrinder appliance definitions from [here](http://github.com/rubiojr/boxgrinder-appliances). Let's check them out using git:

    $ git clone http://github.com/rubiojr/boxgrinder-appliances

We’ll use a Ubuntu appliance definition to generate a new appliance:

    $ cd boxgrinder-appliances/ubuntu-jeos

    $ boxgrinder-build -l boxgrinder-ubuntu-plugin,esx-delivery-plugin \
                       -p vmware --platform-config type:personal,thin_disk:true \
                       -d esx \
                       --delivery-config esx_host:esx-test-host,esx_user:root,esx_password:temporal \
                               oneiric.appl

This will build the Ubuntu Oneiric appliance and deliver it to the ESX host configured.

#ESX delivery plugin configuration parameters

The ESX Boxgrinder delivery plugin accepts the following list of config parameters:

**esx_host:** the ESX hostname/ipaddress

**esx_user:** the ESX user to use

**esx_password:** the ESX password to use

**datastore:** the ESX datastore to use

**name:** the appliance name.

**memory:** the amount of RAM the appliance will have.

**cpu:** the number of CPUs the appliance will have.

All the config parameters have default values. Use the **--delivery-config** Boxgrinder parameter to configure the appliance upload to fit your needs.

Make sure you define at lease the esx_host, esx_user and esx_password parametes to fit your needs.

# Copyright

Copyright (c) 2011 Sergio Rubio. See LICENSE.txt for
further details.

