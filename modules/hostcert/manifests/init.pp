#
# Class: hostcerts
#
# hostcert (host and http) distribution
# relies on fileserver config providing [certificates]
#
class hostcert {

	include osg-ca-certs

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
		require => [ File["/etc/grid-security"], Class["osg-ca-certs"], ],
	}

	file { "hostkey.pem":
		path    => "/etc/grid-security/hostkey.pem",
		owner   => "root", group => "root", mode => 600,
		source  => "puppet://red-man.unl.edu/hostcert/${hostname}-hostkey.pem",
		require => [ File["/etc/grid-security"], Class["osg-ca-certs"], ],
	}


	file { "httpcert.pem":
		path    => "/etc/grid-security/http/httpcert.pem",
		owner   => "root", group => "root", mode => 644,
		source  => [ "puppet://red-man.unl.edu/hostcert/${hostname}-httpcert.pem",
		             "puppet://red-man.unl.edu/hostcert/${hostname}-hostcert.pem", ],
		require => [ File["/etc/grid-security"], Class["osg-ca-certs"], ],
	}

	file { "httpkey.pem":
		path    => "/etc/grid-security/http/httpkey.pem",
		owner   => "root", group => "root", mode => 600,
		source  => [ "puppet://red-man.unl.edu/hostcert/${hostname}-httpkey.pem",
		             "puppet://red-man.unl.edu/hostcert/${hostname}-hostkey.pem", ],
		require => [ File["/etc/grid-security"], Class["osg-ca-certs"], ],
	}

}
