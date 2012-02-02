
node /demo\d\d\d/ inherits red-private {
	$sshExtraAdmins = [ 'acaprez', 'aguru', 'jwang', 'dweitzel', 'bbockelm' ]
	$sudoExtraAdmins = [ 'acaprez', 'aguru', 'tharvill', 'jthiltge', 'jsamuels', 'jwang', 'dweitzel', 'bbockelm' ]


	include general


	# mount sh-util for benchmarking
   file { "/util": ensure => directory }
   mount { "/util":
      device  => "sh-util:/mnt/util/PF",
      fstype  => "nfs",
      ensure  => mounted,
      options => "rw,noatime,tcp,nolock,hard,intr,rsize=32768,wsize=32768",
      atboot  => true,
      require => File["/util"],
   }
}

