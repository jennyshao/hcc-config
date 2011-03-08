# Class: fetch-crl::disable
#
# Stops fetch-crl service and disables it at boot time
# Removes the monitor checks, but not the other extended elements (backup, firewall)
# Use fetch-crl::absent to remove everything
#
# Usage:
# include fetch-crl::disable
#
class fetch-crl::disable inherits fetch-crl {

    require fetch-crl::params

    Service["fetch-crl"] {
        ensure => "stopped" ,
        enable => "false",
    }

    # Remove relevant monitor, backup, firewall entries
    if $monitor == "yes" { include fetch-crl::monitor::absent }
    # if $backup == "yes" { include fetch-crl::backup::absent }
    # if $firewall == "yes" { include fetch-crl::firewall::absent  }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include fetch-crl::debug }

}
