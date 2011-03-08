# Class: fetch-crl::monitor::absent
#
# Remove fetch-crl monitor elements
#
class fetch-crl::monitor::absent {

    include fetch-crl::params

    # Port monitoring
    monitor::port { "fetch-crl_${fetch-crl::params::protocol}_${fetch-crl::params::port}": 
        protocol => "${fetch-crl::params::protocol}",
        port     => "${fetch-crl::params::port}",
        target   => "${fetch-crl::params::monitor_target_real}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }
    
    # URL monitoring 
    monitor::url { "fetch-crl_url":
        url      => "${fetch-crl::params::monitor_baseurl_real}/index.php",
        pattern  => "${fetch-crl::params::monitor_url_pattern}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

    # Process monitoring 
    monitor::process { "fetch-crl_process":
        process  => "${fetch-crl::params::processname}",
        service  => "${fetch-crl::params::servicename}",
        pidfile  => "${fetch-crl::params::pidfile}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

    # Use a specific plugin (according to the monitor tool used)
    monitor::plugin { "fetch-crl_plugin":
        plugin   => "fetch-crl",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

}
