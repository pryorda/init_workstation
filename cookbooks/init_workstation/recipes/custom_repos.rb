# frozen_string_literal: true

#
# Cookbook:: init_workstation
# Recipe:: custom_repos
#
# Copyright:: 2018, The Authors, All Rights Reserved.
# Install custom repos

node['custom_repos'].each_pair do |ppa, details|
  apt_repository ppa do
    uri details['uri']
    distribution details.fetch('codename', node['lsb']['codename'])
    key details.fetch('key', nil)
    arch details.fetch('arch', nil)
    components details.fetch('components', [])
  end
end

apt_update
