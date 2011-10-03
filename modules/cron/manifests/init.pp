#
# Class: cron
#

class cron {

	file { "cron.allow":
		path    => "/etc/cron.allow",
		owner   => "root", group => "root", mode => 644,
		content => template("cron/cron.allow.erb"),
	}

}

