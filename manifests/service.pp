class singularity::service inherits singularity {
  require ::singularity::install

  if $::singularity::service_provider == 'systemd'  {
    file { "${::singularity::systemd_path}/${::singularity::service_name}.service":
      ensure  => 'present',
      content => template("${module_name}/singularity.service.erb"),
      }
      ~> exec { 'systemctl daemon-reload # for singularity':
        refreshonly => true,
        path        => $::path,
        notify      => Service[$::singularity::service_name]
      }
  }

  service { $::singularity::service_name:
    ensure     => $::singularity::service_ensure,
    hasstatus  => true,
    hasrestart => true,
    provider   => $::singularity::service_provider,
    enable     => true,
    require    => [
      Class['::singularity::install'],
      File["${::singularity::install_dir}/singularity.yml"]
    ],
  }

  if $::singularity::restart_on_change {
    File["${::singularity::install_dir}/singularity.yml"] ~> Service[$::singularity::service_name]
  }
}
