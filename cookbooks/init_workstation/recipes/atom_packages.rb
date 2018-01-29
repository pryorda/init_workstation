# frozen_string_literal: true

#
# Cookbook:: init_workstation
# Recipe:: atom_packages
#
# Copyright:: 2018, The Authors, All Rights Reserved.
# Install Atom Packages

node['atom_packages'].each do |ap|
  execute ap do
    command "apm install #{ap}"
    not_if "apm ls |grep -q #{ap}"
  end
end
