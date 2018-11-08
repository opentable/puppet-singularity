class singularity::install::archive inherits singularity::install {
  $singularity_url  = $::singularity::singularity_url ? {
    undef   => "http://search.maven.org/remotecontent?filepath=com/hubspot/SingularityService/${::singularity::singularity_version}/SingularityService-${::singularity::singularity_version}.jar",
    default => $::singularity::singularity_url,
  }

  file { "/${::singularity::install_dir}":
    ensure => directory
  } ->

  file { "/${::singularity::log_directory}":
    ensure => directory
  } ->

  remote_file { "${::singularity::install_dir}/singularity-${::singularity::singularity_version}.jar":
    ensure => present,
    source => $singularity_url,
  }

  file { "/${::singularity::install_dir}/run.sh":
      ensure  => file,
      content => template("${module_name}/singularity-run.sh.erb"),
      mode    => "0744",
      notify  => Service['singularity']
  }


}
