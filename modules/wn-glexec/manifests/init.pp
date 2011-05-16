#
# Class: wn-glexec
#
# Maintains glexec configs
#
# does -not- restart/install, only config management for now
#
class wn-glexec {
   
   # build the directory Structure
    
	# main glexec config
	file { "/etc/glexec/testglexec":
		ensure  => present,
		owner   => "root", group => "root", mode => 644,
		source  => "puppet://red-man.unl.edu/wn-glexec/testglexec",
	}

}

