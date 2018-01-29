# frozen_string_literal: true

#
# Cookbook:: init_workstation
# Recipe:: gems
#
# Copyright:: 2018, The Authors, All Rights Reserved.
# Install Gems

node['gems'].each_pair do |g, version|
  gem_package g do
    version version
  end
end
