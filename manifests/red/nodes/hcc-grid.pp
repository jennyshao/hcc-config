### red gatekeepers

node 'pf-grid.unl.edu' inherits red-public {

# TODO: fix up base classes so things won't break on .229 dual homed machines

	$sshExtraAdmins = [ 'acaprez', 'aguru', 'jwang', 'dweitzel', 'bbockelm' ]
	$sudoExtraAdmins = [ 'acaprez', 'aguru', 'tharvill', 'jthiltge', 'jsamuels', 'jwang', 'dweitzel', 'bbockelm' ]


	include puppet
	include at
	include cron

#	include users
#	include pam
#	include openssh
#	include sudo
}

