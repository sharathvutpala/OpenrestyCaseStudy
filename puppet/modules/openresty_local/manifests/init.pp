
class openresty_local {

  $path = '/opt/openresty-packaging'
  $package_source = '/opt/openresty-packaging/deb/openresty_1.13.6.1-1~xenial1_amd64.deb'

  include 'docker'

  file { "${path}/script.sh":

    ensure => present,
    source => 'puppet:///modules/openresty_local/install.sh',
    mode   => '0755',
    owner  => 'root',
    group  => 'root',
  }->
  exec { 'run the instaler script':

    command => "${path}/script.sh",
    cwd     => $path,
    user    => 'root',
  }->

  package { 'openresty_local':

    ensure   => latest,
    provider => dpkg,
    source   => $package_source,
  }
}
