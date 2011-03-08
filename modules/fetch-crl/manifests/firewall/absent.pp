# Class: fetch-crl::firewall::absent
#
# Remove fetch-crl firewall elements
#
class fetch-crl::firewall::absent {

    include fetch-crl::params

    firewall { "fetch-crl_${fetch-crl::params::protocol}_${fetch-crl::params::port}":
        source      => "${fetch-crl::params::firewall_source_real}",
        destination => "${fetch-crl::params::firewall_destination_real}",
        protocol    => "${fetch-crl::params::protocol}",
        port        => "${fetch-crl::params::port}",
        action      => "allow",
        direction   => "input",
        enable      => "false",
    }

}
