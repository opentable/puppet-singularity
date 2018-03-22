class singularity (
  String  $version = '1.0',
) inherits singularity::params {

  contain singularity::install
  contain singularity::config

  Class['singularity::install']
  ->Class['singularity::config']

}
