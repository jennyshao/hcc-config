#
# Class: nrpe
#

class nrpe {

	package { "nrpe": ensure => present, }
	package { "nagios-plugins-all": ensure => present, }
	package { "megaraid-cli": ensure => present, }

	service { "nrpe":
		ensure => running,
		enable => true,
		hasrestart => true,
		hasstatus => true,
		require => [ Package["nrpe"], File["sudo-nrpe"], ],
		subscribe => File["nrpe.cfg"],
	}

	file { "nrpe.cfg":
		path => "/etc/nagios/nrpe.cfg",
		owner => "root", group => "root", mode => 644,
		content => template("nrpe/nrpe.cfg.erb"),
		require => Package["nrpe"],
	}

	file { "sudo-nrpe":
		path => "/etc/sudoers.d/sudo-nrpe",
		owner => "root", group => "root", mode => 0440,
		require => Class["sudo"],
		source => "puppet:///modules/nrpe/sudo-nrpe",
	}

	file { "check_host_cert":
		path => "/usr/lib64/nagios/plugins/check_host_cert",
		owner => "root", group => "root", mode => 755,
		source => "puppet:///modules/nrpe/check_host_cert",
		require => Package["nagios-plugins-all"],
	}

	file { "check_megaraid_sas":
		path => "/usr/lib64/nagios/plugins/check_megaraid_sas",
		owner => "root", group => "root", mode => 755,
		source => "puppet:///modules/nrpe/check_megaraid_sas",
		require => Package["nagios-plugins-all"],
	}

}
