class singularity::install inherits singularity {
  case $::singularity::install_method {
    'archive': {
      include singularity::install::archive
    }
    default: {
      fail('Only valid installation method is `archive` for now')
    }
  }
}
