# frozen_string_literal: true

#
# Cookbook:: init_workstation
# Recipe:: remote_fies
#
# Copyright:: 2018, The Authors, All Rights Reserved.
# Download all remote files

node['remote_files'].each_pair do |rf, details|
  remote_file details.fetch('destination', "/home/#{ENV['SUDO_USER']}/Downloads/#{rf}") do
    source details['source']
    mode details.fetch('mode', 0o644)
  end
end

node['s3_files'].each_pair do |s3f, details|
  s3_file details.fetch('destination', "/home/#{ENV['SUDO_USER']}/Downloads/#{s3f}") do
    remote_path details['source']
    bucket details['bucket']
    aws_access_key_id ENV['MINIO_ACCESS_KEY'] ? ENV['MINIO_ACCESS_KEY'] : ENV['AWS_ACCESS_KEY_ID']
    aws_secret_access_key ENV['MINIO_SECRET_KEY'] ? ENV['MINIO_SECRET_KEY'] : ENV['AWS_SECRET_ACCESS_KEY']
    s3_url details.fetch('s3_url', "https://s3.amazonaws.com/#{details['bucket']}")
    owner details.fetch('user', ENV['SUDO_USER'])
    group details.fetch('group', ENV['SUDO_USER'])
    mode details.fetch('mode', 0o644)
    ignore_failure details.fetch('ignore_failure', true)
    action :create
  end
end
