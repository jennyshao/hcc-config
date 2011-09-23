#
# Class: hostcerts
#
# hostcert (host and http) distribution
# relies on fileserver config providing [certificates]
#
class hostcert {

	file { "/etc/grid-security":
		ensure => directory,
		owner  => "root", group => "root", mode => 0755,
	}

	file { "/etc/grid-security/http":
		ensure => directory,
		owner  => "root", group => "root", mode => 0755,
	}


	file { "hostcert.pem":
		path    => "/etc/grid-security/hostcert.pem",
		owner   => "root", group => "root", mode => 644,
		source  => "puppet://red-man.unl.edu/hostcert/${hostname}-hostcert.pem",
		require => File["/etc/grid-security"],
	}

	file { "hostkey.pem":
		path    => "/etc/grid-security/hostkey.pem",
		owner   => "root", group => "root", mode => 600,
		source  => "puppet://red-man.unl.edu/hostcert/${hostname}-hostkey.pem",
		require => File["/etc/grid-security"],
	}


	file { "httpcert.pem":
		path    => "/etc/grid-security/http/httpcert.pem",
		owner   => "root", group => "root", mode => 644,
		source  => "puppet://red-man.unl.edu/hostcert/${hostname}-httpcert.pem",
		require => File["/etc/grid-security/http"],
	}

	file { "httpkey.pem":
		path    => "/etc/grid-security/http/httpkey.pem",
		owner   => "root", group => "root", mode => 600,
		source  => "puppet://red-man.unl.edu/hostcert/${hostname}-httpkey.pem",
		require => File["/etc/grid-security/http"],
	}

}
