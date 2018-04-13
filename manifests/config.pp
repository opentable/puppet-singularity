class singularity::config inherits singularity {
  file {"${::singularity::install_dir}/singularity.yml":
      ensure  => file,
      content => template('singularity/singularity.yml.erb'),
      notify  => Service['singularity'],
  }
}
