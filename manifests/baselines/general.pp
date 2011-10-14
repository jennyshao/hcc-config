# general baseline class for all nodes
# this gets called from the actual node definitions
# similar to exampe42 baselines

class general {

	# general class imports all minimal settings
	include minimal

	# modules that everything should use
	include ntp
	include timezone
	include snmp
	include at
	include cron

   include users
   include pam
   include openssh
   include sudo
   include autofs

	# role specific classes are included here
	if ( $role ) { include "role_$role" }

	# include testing classes if $testing = "yes"
	if ( $testing == "yes" ) { include "testing" }

}
