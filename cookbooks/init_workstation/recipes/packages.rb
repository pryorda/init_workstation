# frozen_string_literal: true

#
# Cookbook:: init_workstation
# Recipe:: packages
#
# Copyright:: 2018, The Authors, All Rights Reserved.
# Install Packages

node['base_packages'].each do |p|
  package p
end

node['custom_packages'].each_pair do |p, details|
  remote_file "/tmp/#{p}.#{details['type']}" do
    source details.fetch('source', nil)
    mode 0o644
    checksum details.fetch('checksum', nil)
  end

  type = details['type']
  case type
  when 'zip'
    execute "extract #{p}" do
      cwd '/tmp'
      command "unzip /tmp/#{p}.#{details['type']}"
      action :run
    end
    execute "install #{p}" do
      command "mv /tmp/#{p} /usr/bin/"
      action :run
    end
  else
    dpkg_package p do
      source "/tmp/#{p}.deb"
    end
  end
end

if node['apt_upgrade'] == true
  execute 'apt_upgrade' do
    command 'apt upgrade -y'
    action :run
  end
end
