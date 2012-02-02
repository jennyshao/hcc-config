class role_red-vm {

#	include ganglia
#	include openldap

	include red-vm

	yumrepo { "nebraska-el6":
		baseurl => "http://t2.unl.edu/store/repos/nebraska/6/nebraska-el6/x86_64/",
		descr => "Nebraska EL6 Packages",
		enabled => 1,
		gpgcheck => 0,
		http_caching => none,
		priority => "97",
	}

}
