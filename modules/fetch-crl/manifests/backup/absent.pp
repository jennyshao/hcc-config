# Class: fetch-crl::backup::absent
#
# Remove fetch-crl backup elements
#
class fetch-crl::backup::absent {

    include fetch-crl::params

    backup { "fetch-crl_data": 
        frequency => "${fetch-crl::params::backup_frequency}",
        path      => "${fetch-crl::params::datadir}",
        enabled   => "false",
        target    => "${fetch-crl::params::backup_target_real}",
    }
    
    backup { "fetch-crl_logs": 
        frequency => "${fetch-crl::params::backup_frequency}",
        path      => "${fetch-crl::params::logdir}",
        enabled   => "false",
        target    => "${fetch-crl::params::backup_target_real}",
    }

}
