#
# Class: fetch-crl::debug
#
# This class is used only for debugging purposes
#
# Usage:
# This class is autoloaded if you set $debug=yes
#
class fetch-crl::debug {

    # Load the variables used in this module. Check the params.pp file 
    require fetch-crl::params
    include puppet::debug
    include puppet::params

    file { "puppet_debug_variables_fetch-crl":
        path    => "${puppet::params::debugdir}/variables/fetch-crl",
        mode    => "${fetch-crl::params::configfile_mode}",
        owner   => "${fetch-crl::params::configfile_owner}",
        group   => "${fetch-crl::params::configfile_group}",
        ensure  => present,
        require => File["puppet_debug_variables"],
        content => template("fetch-crl/variables_fetch-crl.erb"),
    }

}
