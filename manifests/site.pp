group { "puppet":
  ensure => present,
}

$tomcat_max_heap = '2048m'

########### java setup
package { 'java' :
  name   => 'openjdk-7-jdk',
  ensure => present,
  before => Class['tomcat7']
}

########### tomcat setup
include tomcat7

$tomcatHome = '/home/vagrant/tomcat7'
$tomcatAlternateHome = '/usr/share/tomcat7'

file { $tomcatHome:
  ensure => 'link',
  target => '/var/lib/tomcat7',
  require => Class['tomcat7']
}


$tomcatLogDir = "${tomcatAlternateHome}/logs"
file { $tomcatLogDir:
  require => File[$tomcatHome],
  ensure => directory,
  owner => 'tomcat7',
  group => 'tomcat7',
}

file { "${tomcatHome}/logs2":
  require => File[$tomcatHome],
  ensure => 'link',
  target => $tomcatLogDir,
}

file { "${tomcatHome}/lib":
  require => File[$tomcatHome],
  ensure => 'link',
  target => "${tomcatAlternateHome}/lib",
}

file { "${tomcatAlternateHome}/conf":
  ensure => 'link',
  target => '/etc/tomcat7',
  require => Class['tomcat7']
}

$tomcatBinDir = "${tomcatHome}/bin"
file { $tomcatBinDir:
  ensure => 'link',
  target => "${tomcatAlternateHome}/bin",
  require => File[$tomcatHome],
}

file { "${tomcatBinDir}/tomcat_debug":
  require => File[$tomcatBinDir],
  source => '/vagrant/resources/tomcat/tomcat_debug'
}

file { '/usr/share/tomcat7/common':
  ensure => 'link',
  target => '/var/lib/tomcat7/common',
  require => File[$tomcatHome],
}

file { '/usr/share/tomcat7/server':
  ensure => 'link',
  target => '/var/lib/tomcat7/server',
  require => File[$tomcatHome],
}

file { '/usr/share/tomcat7/shared':
  ensure => 'link',
  target => '/var/lib/tomcat7/shared',
  require => File[$tomcatHome],
}

file { '/usr/share/tomcat7/webapps':
  ensure => 'link',
  force => true,
  target => '/var/lib/tomcat7/webapps',
  require => File[$tomcatHome],
}

file { "${tomcatBinDir}/setenv.sh":
  require => File[$tomcatBinDir],
  ensure => 'present'
}

file_line { 'tomcat_mem':
  require => File["${tomcatBinDir}/setenv.sh"],
  line => "CATALINA_OPTS=-Xmx${tomcat_max_heap}",
  path => "${tomcatBinDir}/setenv.sh",
}


########### solr setup
$solrScript = '/vagrant/scripts/solr.sh'
exec { $solrScript:
  require => File['/usr/share/tomcat7/webapps'],
  logoutput => true,
  command => "${solrScript}",
  timeout => 0
}

