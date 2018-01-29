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
  remote_file "/tmp/#{p}.deb" do
    source details.fetch('source', nil)
    mode 0o644
    checksum details.fetch('checksum', nil)
  end

  dpkg_package p do
    source "/tmp/#{p}.deb"
  end
end
