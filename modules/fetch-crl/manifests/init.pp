#
# Class: fetch-crl
#
# Manages fetch-crl.
# Include it to install and run fetch-crl
# It defines package, service, main configuration file.
#
# Usage:
# include fetch-crl
#
class fetch-crl {

    # Load the variables used in this module. Check the params.pp file 
    require fetch-crl::params

    # Basic Package - Service - Configuration file management
    package { "fetch-crl":
        name   => "${fetch-crl::params::packagename}",
        ensure => present,
    }

    service { "fetch-crl-cron":
        name       => "${fetch-crl::params::servicename}",
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => "${fetch-crl::params::hasstatus}",
        require    => Package["fetch-crl"],
        subscribe  => File["fetch-crl.conf"],
    }

    file { "fetch-crl.conf":
        path    => "${fetch-crl::params::configfile}",
        mode    => "${fetch-crl::params::configfile_mode}",
        owner   => "${fetch-crl::params::configfile_owner}",
        group   => "${fetch-crl::params::configfile_group}",
        ensure  => present,
        require => Package["fetch-crl"],
        notify  => Service["fetch-crl"],
        # content => template("fetch-crl/fetch-crl.conf.erb"),
    }

    # Include OS specific subclasses, if necessary
    case $operatingsystem {
        default: { }
    }

    # Include extended classes, if relevant variables are defined 
    if $backup == "yes" { include fetch-crl::backup }
    if $monitor == "yes" { include fetch-crl::monitor }
    if $firewall == "yes" { include fetch-crl::firewall }

    # Include project specific class if $my_project is set
    # The extra project class is by default looked in fetch-crl module 
    # If $my_project_onmodule == yes it's looked in your project module
    if $my_project { 
        case $my_project_onmodule {
            yes,true: { include "${my_project}::fetch-crl" }
            default: { include "fetch-crl::${my_project}" }
        }
    }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include fetch-crl::debug }

}
