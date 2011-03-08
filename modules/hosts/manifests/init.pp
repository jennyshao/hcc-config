# Class: hosts
#
# This class maintains /etc/hosts
#

class hosts {

	file { "/etc/hosts":
		ensure  => present,
		owner   => "root",
		group   => "root",
		mode    => 644,
		content => template("hosts/hosts.erb"),
	}

	if $my_project { include "hosts::${my_project}" }

} # class hosts
