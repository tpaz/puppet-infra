class infra::puppetmaster (
  $answers = 'infra/puppetmaster.answers.erb',
  $domain_name = $infra::domain_name,
  $puppetdb_server = "puppetdb.${domain_name}"
) inherits infra {

  # Provide the answerfile for the puppet installer
  file { '/etc/foreman/foreman-installer-answers.yaml':
    ensure  => present,
    content => template($answers),
    owner   => root,
    group   => root,
    mode    => '0600',
    require => Package['foreman-installer'],
  }

  class { 'puppetdb::master::config':
    puppetdb_server   => $puppetdb_server,
    require           => Exec['foreman-installer'],
    strict_validation => false,
    restart_puppet    => false
  }

  include infra::installer

}
