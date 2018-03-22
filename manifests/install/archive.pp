class singularity::install::archive inherits singularity::install {
  $download_url = $::singularity::archive_dl_url ? {
    undef   => "https://artifactory.otenv.com/remote-repos/com/hubspot/SingularityService/${version}/SingularityService-${version}-shaded.jar",
    default => $::singularity::archive_dl_url,
  }

  $singularity_jar = "${directory}/singularity-${version}.jar"

  file {
    "/${directory}":
    ensure => directory
  } ->

  exec {
    "Download Singularity":
      command => "/usr/bin/env wget -q -O ${singularity_jar} ${singularity_url}",
      creates => $singularity_jar,
      notify  => Service['singularity']
  } ->

  file {
    "/${directory}/singularity.yml":
      ensure  => file,
      content => template('otmesos/singularity.yml.erb'),
      notify  => Service['singularity']
  } ->

  file {
    "/${directory}/run.sh":
      ensure  => file,
      content => template('otmesos/singularity-run.sh.erb'),
      mode    => "0744",
      notify  => Service['singularity']
  } ->

  file {
    "/etc/init/${service_name}.conf":
      ensure  => file,
      content => template('otmesos/upstart.conf.erb')
  } ~>

  exec {
    "Singularity Reload Upstart":
      command     => "/sbin/initctl reload-configuration",
      before      => Service['singularity'],
      refreshonly => true
  }
}
