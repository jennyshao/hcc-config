# Class: snmp
#
# This class maintains /etc/snmpd/snmpd.conf and /etc/sysconfig/snmpd.options
#
# Parameters:
#
# Actions:
#
# Requires:
#   $snmpLocation must be set in site manifest
#   $snmpContactName must be set in site manifest
#   $snmpContactEmail must be set in site manifest
#   $snmpSources must be set in site manifest
#
# Sample Usage:
#


class snmp {

	package { net-snmp: ensure => latest }

	file { "/etc/snmp/snmpd.conf":
		owner  => "root",
		group  => "root",
		mode   => 644,
		content => template("snmp/snmpd.conf.erb"),
		notify  => Service["snmpd"],
		require => Package["net-snmp"],
	} # file

	service { "snmpd":
		enable => true,
		ensure => running,
		require => Package["net-snmp"],
	} # service

} # class snmp
