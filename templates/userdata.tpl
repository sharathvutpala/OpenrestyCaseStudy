#!/usr/bin/env bash
set -x
source /etc/lsb-release

PKG="puppetlabs-release-pc1-xenial.deb"
URL="https://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb"

# get puppet
sudo wget -nd "https://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb"
sudo dpkg -i  "puppetlabs-release-pc1-xenial.deb"
# adds openresty gpg key

wget -qO - https://openresty.org/package/pubkey.gpg | sudo apt-key add -
sudo add-apt-repository -y "deb http://openresty.org/package/ubuntu xenial main"

sudo apt-get -y update
sudo DEBIAN_FRONTEND="noninteractive" apt-get -y dist-upgrade

sudo apt-get -y install puppet-agent r10k software-properties-common
sudo apt-get -y install libtemplate-perl dh-systemd systemtap-sdt-dev perl gnupg curl make build-essential dh-make bzr-builddeb
