# Class: fetch-crl::absent
#
# Removes fetch-crl package and its relevant monitor, backup, firewall entries
#
# Usage:
# include fetch-crl::absent
#
class fetch-crl::absent {

    require fetch-crl::params

    package { "fetch-crl":
        name   => "${fetch-crl::params::packagename}",
        ensure => absent,
    }

    # Remove relevant monitor, backup, firewall entries
    if $monitor == "yes" { include fetch-crl::monitor::absent }
    if $backup == "yes" { include fetch-crl::backup::absent }
    if $firewall == "yes" { include fetch-crl::firewall::absent  }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include fetch-crl::debug }

}
