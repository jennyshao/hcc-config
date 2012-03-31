#
# yum repo management
#

class yum {

	include yum::params

	case $operatingsystem {

		centos: {
			if $lsbmajdistrelease == "5" { include yum::repo::centos5 }
			if $lsbmajdistrelease == "6" { include yum::repo::centos6 }
			if $yum::params::extrarepo =~ /epel/ { include yum::repo::epel }
			if $yum::params::extrarepo =~ /nebraska/ { include yum::repo::nebraska }
			if $yum::params::extrarepo =~ /osg/ { include yum::repo::osg }
		}

		scientific: {
			if $lsbmajdistrelease == "5" { include yum::repo::sl5 }
			if $lsbmajdistrelease == "6" { include yum::repo::sl6 }
			if $yum::params::extrarepo =~ /epel/ { include yum::repo::epel }
			if $yum::params::extrarepo =~ /nebraska/ { include yum::repo::nebraska }
			if $yum::params::extrarepo =~ /osg/ { include yum::repo::osg }
		}

		redhat: {
		}

		default: { fail("no managed repo defined for this distro") }

	}

}
