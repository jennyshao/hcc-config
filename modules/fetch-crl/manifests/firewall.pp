# Class: fetch-crl::firewall
#
# Manages fetch-crl firewalling using custom Firewall wrapper
# By default it opens fetch-crl's default port(s) to anybody
# It's automatically included if $firewall=yes
#
# Usage:
# Automatically included if $firewall=yes 
#
class fetch-crl::firewall {

    include fetch-crl::params

    firewall { "fetch-crl_${fetch-crl::params::protocol}_${fetch-crl::params::port}":
        source      => "${fetch-crl::params::firewall_source_real}",
        destination => "${fetch-crl::params::firewall_destination_real}",
        protocol    => "${fetch-crl::params::protocol}",
        port        => "${fetch-crl::params::port}",
        action      => "allow",
        direction   => "input",
        enable      => "${fetch-crl::params::firewall_enable}",
    }

}
