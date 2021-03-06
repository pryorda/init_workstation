#!/bin/bash
VERSION="2.3.17"
# Install Chefdk
test -e /tmp/chefdk_${VERSION}-1_amd64.deb || curl -sk -o /tmp/chefdk_${VERSION}-1_amd64.deb https://packages.chef.io/files/current/chefdk/${VERSION}/ubuntu/16.04/chefdk_${VERSION}-1_amd64.deb
dpkg -l |grep -q chefdk || sudo dpkg -i /tmp/chefdk_${VERSION}-1_amd64.deb
grep -q "shell-init" ~/.bash_profile || echo 'eval "$(chef shell-init bash)"' >> ~/.bash_profile
cd cookbooks/init_workstation || exit && berks vendor ../ ; cd - || exit 1
sudo -E chef-solo -c "$(pwd)"/solo.rb -j "$(pwd)"/node.json

sudo rm -rf lastpass* https* chef-client* nodes remote_file local-mode-cache cookbooks/init_workstation/metadata.json cookbooks/s3_file
