class singularity::config inherits singularity {

  file {"${::singularity::install_dir}/singularity.yml":
      ensure  => file,
      content => template('singularity/singularity.yml.erb'),
      notify  => Service['singularity'],
  }

  exec { "check_filebeat_exist":
    command => "true",
    path    =>  ["/usr/bin","/usr/sbin", "/bin"],
    onlyif  => "test -f /etc/filebeat/conf.d/singularity-master.yml"
  }

  file { "/etc/rsyslog.d/singularity.conf":
    ensure  => file,
    content => "if \$programname == 'singularity' then /var/log/singularity.log",
    require => Exec["check_filebeat_exist"],
    notify  => Service['filebeat'],
  }

}
