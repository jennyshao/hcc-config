### red bestman servers

node 'red-srm1.unl.edu' inherits red-public {
	$role = "red-srm"
   include general
	include nrpe
}

node 'red-srm2.unl.edu' inherits red-public {

#	$role = "red-srm"

#	$mountsHDFS = "True"

#	include puppet

#	package { ['htop', 'dstat', 'sysstat', 'screen', 'nmap']: ensure => present }

	yumrepo { 'nebraska':
		baseurl => 'http://red-man.unl.edu/cobbler/repo_mirror/nebraska/',
		descr => 'Nebraska EL5 Packages',
		enabled => 1,
		gpgcheck => 0,
		http_caching => none,
		priority => 97,
	}

#	include general
#	include sudo
#	include nrpe
#	include autofs
#	include ganglia
#	include users
#	include pam
#	include openssh
#	include hadoop
#	include bestman
#	include osg-ca-certs
#	include hostcert

}

