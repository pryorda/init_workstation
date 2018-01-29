# frozen_string_literal: true

#
# Cookbook:: init_workstation
# Recipe:: user_configuration
#
# Copyright:: 2018, The Authors, All Rights Reserved.
# Configures and modifies user.

group 'docker' do
  action :modify
  append true
  members [ENV['SUDO_USER']]
end
