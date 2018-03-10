# frozen_string_literal: true

#
# Cookbook:: init_workstation
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
# Install Packages

include_recipe 'init_workstation::custom_repos'
include_recipe 'init_workstation::packages'
include_recipe 'init_workstation::atom_packages'
include_recipe 'init_workstation::gems'
include_recipe 'init_workstation::remote_files'
include_recipe 'init_workstation::user_configuration'
include_recipe 'init_workstation::install_lastpass_cli'
include_recipe 'init_workstation::install_docker_zoom'
