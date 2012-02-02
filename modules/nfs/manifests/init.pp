#
# Class: nfs
#
# include nfs::server for fileservers
#

class nfs {

	package { "nfs-utils": ensure => present, }

	# idmapd needed for nfs4 with same domains (hcc.unl.edu in our case)

	service { "rpcidmapd":
		name => "rpcidmapd",
		ensure => running,
		enable => true,
		hasrestart => true,
		hasstatus => true,
		require => Package["nfs-utils"],
		subscribe => File["idmapd.conf"],
	}

	file { "idmapd.conf":
		path => "/etc/idmapd.conf",
		owner => "root", group => "root", mode => "0640",
		require => Package["nfs-utils"],
		notify => Service["rpcidmapd"],
		source => $lsbmajdistrelease ? {
			6 => "puppet:///nfs/idmapd.conf-rhel6",
			default => "puppet:///nfs/idmapd.conf-rhel5",
		}
	}

}
