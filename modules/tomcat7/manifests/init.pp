# Class: tomcat7
#
# This module manages tomcat7
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#

class tomcat7 {
      package { 'tomcat7':
        ensure => 'installed',
      }
      
      service {'tomcat7':
        ensure => running,
        enable => true,
        require => Package['tomcat7'],
        subscribe => Package['tomcat7'],
      }
      
      
}
