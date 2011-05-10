#
# Class: condor
#
# Maintains condor configs
#
# does -not- restart/install, only config management for now
#
# TODO: split logic into separate sub classes (workers, submitters, collectors, etc...)
#
# FILE					exists on...
# -------------------------------
# 00-red					workers, submitters, collector
# 01-red-worker		workers
# 02-red-collector	collector
# 03-red-submitter	submitters
# 04-red-external		submitters, collector
# 05-htpc				<whole machine crap, so nowhere now>
# 09-thpc				THPC nodes
# 09-r410				KSU's r410 nodes (189-200)
#

class condor {

	# create condor_config.local if missing, but do not maintain it
	file { "/etc/condor/condor_config.local":
		owner   => "root", group => "root", mode => 644,
		ensure  => present,
	}

	# clean config.d
	file { "/etc/condor/config.d":
		ensure => directory,
		owner   => "root", group => "root", mode => 0644,
		recurse => true,
		purge   => true,
		force   => true,
	}

	# main condor config
	file { "/etc/condor/config.d/00-red":
		ensure  => present,
		owner   => "root", group => "root", mode => 644,
		source  => "puppet://red-man.unl.edu/condor/config.d/00-red",
	}

	if $isCondorWorker {
		file { "/etc/condor/config.d/01-red-worker":
			ensure => present,
			owner  => "root", group => "root", mode => 644,
			source => "puppet://red-man.unl.edu/condor/config.d/01-red-worker",
		}
	}

	if $isCondorCollector {
		file { "/etc/condor/config.d/02-red-collector":
			ensure => present,
			owner  => "root", group => "root", mode => 644,
			source => "puppet://red-man.unl.edu/condor/config.d/02-red-collector",
		}

		file { "/etc/condor/config.d/04-red-external":
			ensure => present,
			owner  => "root", group => "root", mode => 644,
			source => "puppet://red-man.unl.edu/condor/config.d/04-red-external",
		}

		file { "/etc/condor/condor_mapfile":
			ensure => present,
			owner  => "root", group => "root", mode => 644,
			source => "puppet://red-man.unl.edu/condor/condor_mapfile",
		}
	}

	if $isCondorSubmitter {
		file { "/etc/condor/config.d/03-red-submitter":
			ensure => present,
			owner  => "root", group => "root", mode => 644,
			source => "puppet://red-man.unl.edu/condor/config.d/03-red-submitter",
		}

		file { "/etc/condor/config.d/04-red-external":
			ensure => present,
			owner  => "root", group => "root", mode => 644,
			source => "puppet://red-man.unl.edu/condor/config.d/04-red-external",
		}

		file { "/etc/condor/condor_mapfile":
			ensure => present,
			owner  => "root", group => "root", mode => 644,
			source => "puppet://red-man.unl.edu/condor/condor_mapfile",
		}
	}

}

