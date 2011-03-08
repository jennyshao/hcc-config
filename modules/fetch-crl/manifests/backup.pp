# Class: fetch-crl::backup
#
# Backups fetch-crl data and logs using Example42 backup meta module (to be adapted to custom backup solutions)
# It's automatically included and used if $backup=yes
# This class permits to abstract what you want to backup from the tool and module to use for backups.
#
# Variables:
# The behaviour of this class has some defaults that can be overriden by user's variables:
# $fetch-crl_backup_data (true|false) : Set if you want to backup fetch-crl's data. Default: As defined in $backup_data
# $fetch-crl_backup_log (true|false) : Set if you want to backup fetch-crl's logs. Default: As defined in $backup_log
# $fetch-crl_backup_frequency (hourly|daily|weekly|monthly) : Set the frequency of your fetch-crl backups. Default: daily.
# $fetch-crl_backup_target : Define how to reach (Ip, fqdn...) this host to backup fetch-crl from an external server. Default: As defined in $backup_target
# 
# You can also set some site wide variables that can be overriden by the above module specific ones:
# $backup_data (true|false) : Set if you want to enable data backups site-wide. 
# $backup_log (true|false) : Set if you want to enable logs backups site-wide. 
# $backup_target : Set the ip/hostname you want to use on an external backup server to backup this host
# For the defaults of the above variables check fetch-crl::params
#
# Usage:
# Automatically included if $backup=yes
#
class fetch-crl::backup {

    include fetch-crl::params

    backup { "fetch-crl_data": 
        frequency => "${fetch-crl::params::backup_frequency}",
        path      => "${fetch-crl::params::datadir}",
        enabled   => "${fetch-crl::params::backup_data_enable}",
        target    => "${fetch-crl::params::backup_target_real}",
    }
    
    backup { "fetch-crl_logs": 
        frequency => "${fetch-crl::params::backup_frequency}",
        path      => "${fetch-crl::params::logdir}",
        enabled   => "${fetch-crl::params::backup_log_enable}",
        target    => "${fetch-crl::params::backup_target_real}",
    }

    # Include project specific backup class if $my_project is set
    if $my_project { 
        case $my_project_onmodule {
            yes,true: { include "${my_project}::fetch-crl::backup" }
            default: { include "fetch-crl::${my_project}::backup" }
        }
    }

}
