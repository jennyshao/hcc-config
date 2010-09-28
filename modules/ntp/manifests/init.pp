
class ntp {

	$ntpServerList = ['red.unl.edu', 'gpn-husker.unl.edu', 't3.unl.edu']
	package { ntp: ensure => latest }

	file { "/etc/ntp.conf":
		owner   => "root",
		group   => "root",
		mode    => "644",
		content => template("ntp/client-ntp.conf.erb"),
		notify  => Service["ntpd"],
		require => Package["ntp"],
	}

	service { "ntpd":
		enable  => true,
		ensure  => running,
		require => Package["ntp"],
#		subscribe => File['/etc/ntp.conf'],
	}
}

