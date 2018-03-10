# frozen_string_literal: true

#
# Cookbook:: init_workstation
# Recipe:: install_docker_zoom.rb
#
# Copyright:: 2018, The Authors, All Rights Reserved.
# Download all remote files

execute 'install docker zoom' do
  command 'docker run --rm --volume /usr/local/bin/:/target mdouchement/zoom-us:latest install'
  not_if 'which zoom'
end
