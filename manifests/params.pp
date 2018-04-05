# Private class.
class singularity::params {
  $carbon_otenv         = hiera('carbon_otenv')
  $install_dir          = "/srv/singularity"
  $install_method       = 'archive'
  $group                = 'root'
  $master_list          = undef
  $maxbuffers           = 16777200
  $service_ensure       = true
  $service_name         = "singularity"
  $service_provider     = "systemd"
  $singularity_version  = '0.19.1'
  $singularity_jar      = "${install_dir}/singularity-${singularity_version}.jar"
  $singularity_url      = undef
  $systemd_path         = '/etc/systemd/system'
  $systemd_unit_after   = 'network.target'
  $systemd_unit_want    = undef
  $user                 = 'root'

  case $::osfamily {
    'Debian': {
      $config_path        = '/etc/singularity/singularity.conf'
    }

    default: {
      fail("Unsupported osfamily: ${::osfamily}, module ${module_name} only support osfamily Debian")
    }
  }

}
