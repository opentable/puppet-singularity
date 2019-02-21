class singularity::config inherits singularity {

  file {"${::singularity::install_dir}/singularity.yml":
      ensure  => file,
      content => template('singularity/singularity.yml.erb'),
      notify  => Service['singularity'],
  }

  if defined(Filebeat::Prospector['singularity-master']) {
    file { "/etc/rsyslog.d/singularity.conf":
      ensure  => file,
      content => "if \$programname == 'singularity' then /var/log/singularity.log",
      require => Filebeat::Prospector['singularity-master'],
      notify  => Service['filebeat'],
    }
  }

}
