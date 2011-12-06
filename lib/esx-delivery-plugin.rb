require 'rubygems'
require 'esx'
require 'boxgrinder-build/plugins/base-plugin'

module BoxGrinder
  class ESXDelivery < BasePlugin
    def validate
      set_default_config_value('datastore', 'datastore1')
      set_default_config_value('name', @appliance_config.name)
      set_default_config_value('esx_user', 'root')
      set_default_config_value('esx_password', '')
      set_default_config_value('esx_host', '127.0.0.1')
      set_default_config_value('cpu', '1')
      set_default_config_value('guest_id', 'otherGuest')
      set_default_config_value('memory', '512')
      set_default_config_value('power_on', 'yes')
    end

    def execute
      @log.info "Uploading #{@appliance_config.name} to ESX host #{@plugin_config['esx_host']}..."

      begin
        #TODO move to a block
        create_vm(@previous_deliverables[:disk])
        @log.info "Appliance #{@appliance_config.name} uploaded."
      rescue => e
        @log.error e
        @log.error "An error occurred while uploading files."
      end
    end
    
    def create_vm(disk_file)
      host = ESX::Host.connect @plugin_config['esx_host'], @plugin_config['esx_user'], @plugin_config['esx_password']
      datastore = @plugin_config['datastore']
      memory = @plugin_config['memory']
      name = @appliance_config.name
      guest_id = @plugin_config['otherGuest']
      @log.info "Creating VM using #{File.basename(disk_file)}..."

      @log.info "Uploading and converting disk..."
      @log.debug "Creating remote dir /vmfs/volumes/#{datastore}/#{name}"
      host.remote_command "mkdir /vmfs/volumes/#{datastore}/#{name}"
      host.import_disk disk_file, "/vmfs/volumes/#{datastore}/#{name}/#{name}.vmdk"
      vm = host.create_vm :vm_name => name,
                          :disk_file => "#{name}/#{name}.vmdk",
                          :datastore => datastore, :disk_type => :flat, :memory => memory,
                          :guest_id => guest_id
      vm.power_on
    end

  end
end

plugin :class => BoxGrinder::ESXDelivery, :type => :delivery, :name => :esx, :full_name  => "Deliver the appliance to an ESX/ESXi host"
