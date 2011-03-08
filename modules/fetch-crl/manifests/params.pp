# Class: fetch-crl::params
#
# Sets internal variables and defaults for fetch-crl module
# This class is loaded in all the classes that use the values set here 
#
class fetch-crl::params  {

## DEFAULTS FOR VARIABLES USERS CAN SET
# (Here are set the defaults, provide your custom variables externally)
# (The default used is in the line with '')

## Example: Full hostname of fetch-crl server
#    $server = $fetch-crl_server ? {
#        ''      => "fetch-crl",
#        default => "${fetch-crl_server}",
#    }


## EXTRA MODULE INTERNAL VARIABLES
#(add here module specific internal variables)



## MODULE INTERNAL VARIABLES
# (Modify to adapt to unsupported OSes)

    $packagename = $operatingsystem ? {
        solaris => "CSWfetch-crl",
        debian  => "fetch-crl",
        ubuntu  => "fetch-crl",
        default => "fetch-crl",
    }

    $servicename = $operatingsystem ? {
        debian  => "fetch-crl",
        ubuntu  => "fetch-crl",
        default => "fetch-crl",
    }

    $processname = $operatingsystem ? {
        default => "fetch-crl",
    }

    $hasstatus = $operatingsystem ? {
        debian  => false,
        ubuntu  => false,
        default => true,
    }

    $configfile = $operatingsystem ? {
        freebsd => "/usr/local/etc/fetch-crl/fetch-crl.conf",
        default => "/etc/fetch-crl/fetch-crl.conf",
    }

    $configfile_mode = $operatingsystem ? {
        default => "644",
    }

    $configfile_owner = $operatingsystem ? {
        default => "root",
    }

    $configfile_group = $operatingsystem ? {
        default => "root",
    }

    $configdir = $operatingsystem ? {
        default => "/etc/fetch-crl",
    }

    $initconfigfile = $operatingsystem ? {
        debian  => "/etc/default/fetch-crl",
        ubuntu  => "/etc/default/fetch-crl",
        default => "/etc/sysconfig/fetch-crl",
    }
    
    # Used by monitor class
    $pidfile = $operatingsystem ? {
        default => "/var/run/fetch-crld.pid",
    }

    # Used by backup class
    $datadir = $operatingsystem ? {
        default => "/var/lib/fetch-crl",
    }

    # Used by backup class - Provide the file name, if there's no dedicated dir
    $logdir = $operatingsystem ? {
        default => "/var/log/fetch-crl",
    }

    # Used by monitor and firewall class
    # If you need to define additional ports, call them $protocol1/$port1 and add the relevant
    # parts in firewall.pp and monitor.pp
    $protocol = "tcp"
    $port = "80"
    


## DEFAULTS FOR MONITOR CLASS
# These are settings that influence the (optional) fetch-crl::monitor class
# You can define these variables or leave the defaults
# The apparently complex variables assignements below follow this logic:
# - If no user variable is set, a reasonable default is used
# - If the user has set a host-wide variable (ex: $monitor_target ) that one is set
# - The host-wide variable can be overriden by a module specific one (ex: $fetch-crl_monitor_target)

    # How the monitor server refers to the monitor target 
    $monitor_target_real = $fetch-crl_monitor_target ? {
        ''      => $monitor_target ? {
           ''      => "${fqdn}",
           default => $monitor_target,
        },
        default => "$fetch-crl_monitor_target",
    }

    # BaseUrl to access this service
    $monitor_baseurl_real = $fetch-crl_monitor_baseurl ? {
        ''      => $monitor_baseurl ? {
           ''      => "http://${fqdn}",
           default => $monitor_baseurl,
        },
        default => "${fetch-crl_monitor_baseurl}",
    }

    # Pattern to look for in the URL defined in fetch-crl::monitor class
    $monitor_url_pattern = $fetch-crl_monitor_url_pattern ? {
        ''      => "OK",
        default => "${fetch-crl_monitor_url_pattern}",
    }

    # If fetch-crl port monitoring is enabled 
    $monitor_port_enable = $fetch-crl_monitor_port ? {
        ''      => $monitor_port ? {
           ''      => true,
           default => $monitor_port,
        },
        default => $fetch-crl_monitor_port,
    }

    # If fetch-crl url monitoring is enabled 
    $monitor_url_enable = $fetch-crl_monitor_url ? {
        ''      => $monitor_url ? {
           ''      => false,
           default => $monitor_url,
        },
        default => $fetch-crl_monitor_url,
    }

    # If fetch-crl process monitoring is enabled 
    $monitor_process_enable = $fetch-crl_monitor_process ? {
        ''      => $monitor_process ? {
           ''      => true,
           default => $monitor_process,
        },
        default => $fetch-crl_monitor_process,
    }

    # If fetch-crl plugin monitoring is enabled 
    $monitor_plugin_enable = $fetch-crl_monitor_plugin ? {
        ''      => $monitor_plugin ? {
           ''      => false,
           default => $monitor_plugin,
        },
        default => $fetch-crl_monitor_plugin,
    }

## DEFAULTS FOR BACKUP CLASS
# These are settings that influence the (optional) fetch-crl::backup class
# You can define these variables or leave the defaults

    # How the backup server refers to the backup target 
    $backup_target_real = $fetch-crl_backup_target ? {
        ''      => $backup_target ? {
           ''      => "${fqdn}",
           default => $backup_target,
        },
        default => "$fetch-crl_backup_target",
    }
  
    # Frequency of backups
    $backup_frequency = $fetch-crl_backup_frequency ? {
        ''      => "daily",
        default => "$fetch-crl_backup_frequency",
    }

    # If fetch-crl data have to be backed up
    $backup_data_enable = $fetch-crl_backup_data ? {
        ''      => $backup_data ? {
           ''      => true,
           default => $backup_data,
        },
        default => $fetch-crl_backup_data,
    }

    # If fetch-crl logs have to be backed up
    $backup_log_enable = $fetch-crl_backup_log ? {
        ''      => $backup_log ? {
           ''      => true,
           default => $backup_log,
        },
        default => $fetch-crl_backup_log,
    }


## DEFAULTS FOR FIREWALL CLASS
# These are settings that influence the (optional) fetch-crl::firewall class
# You can define these variables or leave the defaults

    # Source IPs that can access this service - Use iptables friendly format
    $firewall_source_real = $fetch-crl_firewall_source ? {
        ''      => $firewall_source ? {
           ''      => "0.0.0.0/0",
           default => $firewall_source,
        },
        default => "$fetch-crl_firewall_source",
    }

    # Destination IP to use for this host (Default facter's $ipaddress)
    $firewall_destination_real = $fetch-crl_firewall_destination ? {
        ''      => $firewall_destination ? {
           ''      => "${ipaddress}",
           default => $firewall_destination,
        },
        default => "$fetch-crl_firewall_destination",
    }

    # If firewall filter is enabled
    $firewall_enable = $fetch-crl_firewall_enable ? {
        ''      => $firewall_enable ? {
           ''      => true,
           default => $firewall_enable,
        },
        default => $fetch-crl_firewall_enable,
    }

## FILE SERVING SOURCE
# Sets the correct source for static files
# In order to provide files from different sources without modifying the module
# you can override the default source path setting the variable $base_source
# Ex: $base_source="puppet://ip.of.fileserver" or $base_source="puppet://$servername/myprojectmodule"
# What follows automatically manages the new source standard (with /modules/) from 0.25 

    case $base_source {
        '': {
            $general_base_source = $puppetversion ? {
                /(^0.25)/ => "puppet:///modules",
                /(^0.)/   => "puppet://$servername",
                default   => "puppet:///modules",
            }
        }
        default: { $general_base_source=$base_source }
    }

}
