class singularity::install inherits singularity {
  case $::singularity::install_method {
    'archive': {
      include singularity::install::archive
    }
    default: {
      fail('Only valid installation methods is `archive`')
    }
  }
}
