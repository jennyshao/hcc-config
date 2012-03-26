
class yum::repo::sl5 {

	# the following are the repos from a stock SL5 install

	# [sl-base] from SL5
	yumrepo { 'sl-base':
		baseurl => 'http://rcfzilla.unl.edu/scientific-linux/57/$basearch/SL http://ftp.scientificlinux.org/linux/scientific/57/$basearch/SL',
		descr => 'SL 5 base',
		enabled => 1,
		gpgcheck => 0,
		gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-sl file:///etc/pki/rpm-gpg/RPM-GPG-KEY-sl5 file:///etc/pki/rpm-gpg/RPM-GPG-KEY-csieh file:///etc/pki/rpm-gpg/RPM-GPG-KEY-dawson file:///etc/pki/rpm-gpg/RPM-GPG-KEY-jpolok file:///etc/pki/rpm-gpg/RPM-GPG-KEY-cern file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5',
		priority => 10,
	}

	# [sl-fastbugs] from SL5
	yumrepo { 'sl-fastbugs':
		baseurl => 'http://rcfzilla.unl.edu/scientific-linux/57/$basearch/updates/fastbugs http://ftp.scientificlinux.org/linux/scientific/57/$basearch/updates/fastbugs',
		descr => 'SL 5 fastbugs area',
		enabled => 0,
		gpgcheck => 0,
		gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-sl file:///etc/pki/rpm-gpg/RPM-GPG-KEY-sl5 file:///etc/pki/rpm-gpg/RPM-GPG-KEY-csieh file:///etc/pki/rpm-gpg/RPM-GPG-KEY-dawson file:///etc/pki/rpm-gpg/RPM-GPG-KEY-jpolok file:///etc/pki/rpm-gpg/RPM-GPG-KEY-cern file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5',
		priority => 10,
	}

	# [sl-security] from SL5
	yumrepo { 'sl-security':
		baseurl => 'http://rcfzilla.unl.edu/scientific-linux/57/$basearch/updates/security http://ftp.scientificlinux.org/linux/scientific/57/$basearch/updates/security',
		descr => 'SL 5 security updates',
		enabled => 1,
		gpgcheck => 0,
		gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-sl file:///etc/pki/rpm-gpg/RPM-GPG-KEY-sl5 file:///etc/pki/rpm-gpg/RPM-GPG-KEY-csieh file:///etc/pki/rpm-gpg/RPM-GPG-KEY-dawson file:///etc/pki/rpm-gpg/RPM-GPG-KEY-jpolok file:///etc/pki/rpm-gpg/RPM-GPG-KEY-cern file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5',
		priority => 10,
	}

	# [sl-contrib] from SL5
	yumrepo { 'sl-contrib':
		baseurl => 'http://rcfzilla.unl.edu/scientific-linux/57/$basearch/contrib http://ftp.scientificlinux.org/linux/scientific/57/$basearch/contrib',
		descr => 'Scientific Linux 5 contrib area',
		enabled => 0,
		gpgcheck => 0,
		gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-sl file:///etc/pki/rpm-gpg/RPM-GPG-KEY-sl5 file:///etc/pki/rpm-gpg/RPM-GPG-KEY-csieh file:///etc/pki/rpm-gpg/RPM-GPG-KEY-dawson file:///etc/pki/rpm-gpg/RPM-GPG-KEY-jpolok file:///etc/pki/rpm-gpg/RPM-GPG-KEY-cern file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5',
		priority => 10,
	}

	# [sl-debuginfo] from SL5
	yumrepo { 'sl-debuginfo':
		baseurl => 'http://rcfzilla.unl.edu/scientific-linux/5x/archive/debuginfo http://ftp.scientificlinux.org/linux/scientific/5x/archive/debuginfo',
		descr => 'Scientific Linux 5 debuginfo rpm\'s',
		enabled => 0,
		gpgcheck => 0,
		gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-sl file:///etc/pki/rpm-gpg/RPM-GPG-KEY-sl5 file:///etc/pki/rpm-gpg/RPM-GPG-KEY-csieh file:///etc/pki/rpm-gpg/RPM-GPG-KEY-dawson file:///etc/pki/rpm-gpg/RPM-GPG-KEY-jpolok file:///etc/pki/rpm-gpg/RPM-GPG-KEY-cern file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5',
		priority => 10,
	}

	# [sl-source] from SL5
	yumrepo { 'sl-source':
		baseurl => 'http://rcfzilla.unl.edu/scientific-linux/5x/SRPMS http://ftp.scientificlinux.org/linux/scientific/5x/SRPMS',
		descr => 'Scientific Linux 5 source rpm\'s (src.rpm)',
		enabled => 0,
		gpgcheck => 0,
		gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-sl file:///etc/pki/rpm-gpg/RPM-GPG-KEY-sl5 file:///etc/pki/rpm-gpg/RPM-GPG-KEY-csieh file:///etc/pki/rpm-gpg/RPM-GPG-KEY-dawson file:///etc/pki/rpm-gpg/RPM-GPG-KEY-jpolok file:///etc/pki/rpm-gpg/RPM-GPG-KEY-cern file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5',
		priority => 10,
	}

	# [sl-testing] from SL5
	yumrepo { 'sl-testing':
		baseurl => 'http://rcfzilla.unl.edu/scientific-linux/5rolling/testing/$basearch http://ftp.scientificlinux.org/linux/scientific/5rolling/testing/$basearch',
		descr => 'Scientific Linux 5 testing area',
		enabled => 0,
		gpgcheck => 0,
		gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-sl file:///etc/pki/rpm-gpg/RPM-GPG-KEY-sl5 file:///etc/pki/rpm-gpg/RPM-GPG-KEY-csieh file:///etc/pki/rpm-gpg/RPM-GPG-KEY-dawson file:///etc/pki/rpm-gpg/RPM-GPG-KEY-jpolok file:///etc/pki/rpm-gpg/RPM-GPG-KEY-cern file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5',
		priority => 10,
	}

}
