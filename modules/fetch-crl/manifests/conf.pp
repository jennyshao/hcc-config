# Define fetch-crl::conf
#
# General fetch-crl main configuration file's inline modification define
# Use with caution, it's still at experimental stage and may break in untested circumstances
# Engine, pattern end line parameters can be tweaked for better behaviour
#
# Usage:
# fetch-crl::conf    { "mynetworks":  value => "127.0.0.0/8 10.42.42.0/24" }
#
define fetch-crl::conf ($value) {

    require fetch-crl::params

    config { "fetch-crl_conf_$name":
        file      => "${fetch-crl::params::configfile}",
        line      => "$name = $value",
        pattern   => "^$name ",
        engine    => "replaceline",
        notify    => Service["fetch-crl"],
        require   => File["fetch-crl.conf"],
    }

}
