class singularity (
  String            $carbon_otenv         = $::singularity::params::carbon_otenv,
  String            $external_host        = $::singularity::params::external_host,
  String            $from_email           = $::singularity::params::from_email,
  String            $install_dir          = $::singularity::params::install_dir,
  String            $install_method       = $::singularity::params::install_method,
  String            $group                = $::singularity::params::group,
  String            $log_directory        = $::singularity::params::log_directory,
  Array[String]     $master_list          = $::singularity::params::master_list,
  String            $notify_email         = $::singularity::params::notify_email,
  String            $service_name         = $::singularity::params::service_name,
  String            $service_provider     = $::singularity::params::service_provider,
  String            $singularity_url      = $::singularity::params::singularity_url,
  String            $singularity_version  = $::singularity::params::singularity_version,
  String            $systemd_path         = $::singularity::params::systemd_path,
  Optional[String]  $systemd_unit_want    = $::singularity::params::systemd_unit_want,
  String            $systemd_unit_after   = $::singularity::params::systemd_unit_after,
  String            $user                 = $::singularity::params::user,
  Integer           $zookeeper_max_buffer = $::singularity::params::zookeeper_max_buffer,
) inherits singularity::params {

  include singularity::install
  require singularity::config
  include singularity::service

  Class['singularity::config']
  -> Class['singularity::service']
}
