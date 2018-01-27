#
# Cookbook:: init_workstation
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
# Install Packages

node['custom_repos'].each_pair do |ppa,details|
  apt_repository ppa do
    uri details['uri']
    distribution details.fetch('codename', node['lsb']['codename'])
    key details.fetch('key', nil)
    arch details.fetch('arch', nil)
    components details.fetch('components', [])
  end
end

apt_update

node['base_packages'].each do |p|
  package p
end

node['custom_packages'].each_pair do |p, details|
  remote_file "/tmp/#{p}.deb" do
    source details.fetch('source', nil)
    mode 0644
    checksum details.fetch('checksum', nil)
  end

  dpkg_package p do
    source "/tmp/#{p}.deb"
  end
end

node['atom_packages'].each do |ap|
  execute ap do
    command "apm install #{ap}"
    not_if "apm ls |grep -q #{ap}"
  end
end

group 'docker' do
  action :modify
  append true
  members [ ENV['SUDO_USER'] ]
end
