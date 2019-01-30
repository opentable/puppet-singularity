# Private class.
class singularity::params {
  $carbon_otenv         = hiera('carbon_otenv')
  $external_host        = "${::ipaddress}:7099"
  $from_email           = "no-reply@${::fqdn}"
  $group                = 'root'
  $install_dir          = "/srv/singularity"
  $install_method       = 'archive'
  $log_directory        = '/var/log/singularity'
  $master_list          = undef
  $notify_email         = "admin@${::fqdn}"
  $service_ensure       = true
  $service_name         = "singularity"
  $service_provider     = "systemd"
  $singularity_jar      = "${install_dir}/singularity-${singularity_version}.jar"
  $singularity_url      = undef
  $singularity_version  = '0.19.1'
  $systemd_path         = '/etc/systemd/system'
  $systemd_unit_after   = 'network.target'
  $systemd_unit_want    = undef
  $user                 = 'root'
  $zookeeper_max_buffer = 16777200,
  $mesos_psql_username  = hiera('mesos_psql_username',undef),
  $mesos_psql_password = hiera('mesos_psql_password',undef),
  $mesos_mysql_url      = hiera('mesos_psql_url',undef)


  case $::osfamily {
    'Debian': {
      $config_path        = '/etc/singularity/singularity.conf'
    }

    default: {
      fail("Unsupported osfamily: ${::osfamily}, module ${module_name} only support osfamily Debian")
    }
  }

}
