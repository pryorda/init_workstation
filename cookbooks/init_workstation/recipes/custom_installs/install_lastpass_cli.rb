# frozen_string_literal: true

#
# Cookbook:: init_workstation
# Recipe:: install_lasspass-cli
#
# Copyright:: 2018, The Authors, All Rights Reserved.
# Download all remote files

git "#{Chef::Config[:file_cache_path]}/lastpass-cli" do
  repository 'https://github.com/lastpass/lastpass-cli.git'
  revision 'master'
  action :sync
end

%w[
  openssl libcurl4-openssl-dev libxml2 libssl-dev libxml2-dev pinentry-curses xclip cmake build-essential pkg-config
].each do |pkg|
  package pkg
end

execute 'build and install lastpass-cli' do
  command 'make install'
  cwd "#{Chef::Config[:file_cache_path]}/lastpass-cli"
  not_if 'which lpass'
end
