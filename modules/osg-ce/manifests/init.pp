#
# Class: osg-ce
#
# manages osg-ce
#
class osg-ce {

	file { "config.ini":
		path    => "/opt/osg/osg-1.2/osg/etc/config.ini",
		mode    => 644,
		owner   => "root",
		group   => "root",
		content => template("osg-ce/config.ini.erb"),
		ensure  => present,
	}

}
