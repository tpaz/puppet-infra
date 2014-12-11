class infra::foreman (
  $answers = 'infra/foreman.answers.erb'
) {

  # Provide the answerfile for the puppet installer
  file { '/etc/foreman/foreman-installer-answers.yaml':
    ensure  => present,
    content => template($answers),
    owner   => root,
    group   => root,
    mode    => '0600',
    require => Package['foreman-installer'],
  }

  include infra::installer

}
