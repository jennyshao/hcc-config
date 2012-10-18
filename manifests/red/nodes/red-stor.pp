
# storage nodes in rm17

node /^red-stor\d+\.red\.hcc\.unl\.edu$/ inherits red-public {

	$sshExtraAdmins = [ 'aguru' ]
	$sudoExtraAdmins = [ 'aguru' ]

	$yum_extrarepo = [ 'epel', 'nebraska', 'osg' ]
	$role = "red-stor"

	include general

}
