
node 'red-dev-sl5.red.hcc.unl.edu' inherits red-private {
	include general
}

node 'red-dev-sl6.red.hcc.unl.edu' inherits red-private {
	$sshExtraAdmins = [ 'acaprez', 'aguru', 'jwang', 'dweitzel', 'bbockelm' ]
	$sudoExtraAdmins = [ 'acaprez', 'aguru', 'tharvill', 'jthiltge', 'jsamuels', 'jwang', 'dweitzel', 'bbockelm' ]


	include general

#	include minimal
#   include ntp
#   include timezone
#   include snmp
#   include at
#   include cron

#   include users
#   include pam
#   include openssh
#   include sudo
#   include autofs

}

