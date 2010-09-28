# Class: ntp::server


class ntp::server inherits ntp {
	File["/etc/ntp.conf"] {
		content => template("ntp/server-ntp.conf.erb"),
	}
}
