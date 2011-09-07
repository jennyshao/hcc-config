# Class: openssh
#
# Manages openssh service 
#
# Usage:
# include openssh
# 
# Variables:
#
class openssh {

    # Load the variables used in this module. Check the params.pp file
    require openssh::params

    # Reassigns variables names for use in templates


    # Basic Package 
    package { "openssh":
        name   => "${openssh::params::packagename}",
        ensure => present,
    }
    
    service { "openssh":
        name       => "${openssh::params::servicename}",
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => "${openssh::params::hasstatus}",
        require    => Package["openssh"],
    }

    file { "sshd_config":
        path    => "${openssh::params::configfile}",
        mode    => "${openssh::params::configfile_mode}",
        owner   => "${openssh::params::configfile_owner}",
        group   => "${openssh::params::configfile_group}",
        require => Package["openssh"],
        notify  => Service["openssh"],
        content => template("openssh/sshd_config.erb"),
        ensure  => present,
    }

    file { "openssh-init":
        path    => "${openssh::params::initconfigfile}",
        mode    => "${openssh::params::configfile_mode}",
        owner   => "${openssh::params::configfile_owner}",
        group   => "${openssh::params::configfile_group}",
        require => Package["openssh"],
        ensure  => present,
    }

    ssh_authorized_key { "red-man":
		ensure => "present",
		type => "ssh-rsa",
		key => "AAAAB3NzaC1yc2EAAAABIwAAAQEA3n0Auikb9DBXnMB1z+K1fym59ppEMVB+jvR86kdoyW4GMsnjp0u0MbC29ycCOvPuNg35DSKLNy0SAzBbyuH8ZxfxxTgYtQVeidgTqP0Ot2hac++Iz48/6Yyc8R+qaq6FTuxkeJmPT4wtA1ZjtT5MOZkepYMSCIyM6r4Ey8diTlqpHkqMfHGu9KFJMnux0tqEbZmI2KNXcujbcQ5FBbgZe4YnKFDk3bPnGqxpAgb6FrwUHL4BgVvJlOE2E04i7Zo9M+fB+dHvf1XzJIJ5weoVDUxVUBmEUpOhwdJwBuvCk9R2Ltsga5Jioeau9SgNYZd9uVNr5FY/omAwq2QMVaQPdQ==",
#		options => 'from="red-man.unl.edu,172.16.200.1"',
		user => "root",
    }

    if $puppi == "yes" { include openssh::puppi }
    if $backup == "yes" { include openssh::backup }
    if $monitor == "yes" { include openssh::monitor }
    if $firewall == "yes" { include openssh::firewall }

    case $operatingsystem {
        default: { }
    }

    # Include project specific class if $my_project is set
    # The extra project class is by default looked in openssh module 
    # If $my_project_onmodule == yes it's looked in your project module
    if $my_project { 
        case $my_project_onmodule {
            yes,true: { include "${my_project}::openssh" }
            default: { include "openssh::${my_project}" }
        }
    }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include openssh::debug }

}
