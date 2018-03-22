# Private class.
class singularity::params {

  case $::osfamily {
    'Debian': {
      $package_name       = 'singularity'
      $config_path        = '/etc/singularity/singularity.conf'
    }

    default: {
      fail("Unsupported osfamily: ${::osfamily}, module ${module_name} only support osfamily Debian")
    }
  }

}
