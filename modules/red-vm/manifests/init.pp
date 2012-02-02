#
# Class: red-vm
#
class red-vm {

	file { "multipath.conf":
		ensure => present,
		path => "/etc/multipath.conf",
		mode => "0644", owner => "root", group => "root",
		source => "puppet:///modules/red-vm/multipath.conf-$hostname",
	}

	file { "lvm.conf":
		ensure => present,
		path => "/etc/lvm/lvm.conf",
		mode => "0644", owner => "root", group => "root",
		source => "puppet:///modules/red-vm/lvm.conf-$hostname",
	}

	service { "multipathd":
		ensure => running,
		enable => true,
		hasrestart => true,
		hasstatus => true,
		require => File["multipath.conf"],
		subscribe => File["multipath.conf"],
	}

}
