class yum::params {

	# how to manage yum auto update
	$update = $yum_update ? {
		"cron"     => "cron",
		"updatesd" => "updatesd",
		default    => "off",
	}

	# EPEL is just too useful, enable by default
	$extrarepo = $yum_extrarepo ? {
		""      => "epel",
		default => $yum_extrarepo,
	}

	# name of yum priority package
	$packagename_yumpriority = $lsbmajdistrelease ? {
		5 => "yum-priorities",
		6 => "yum-plugin-priorities",
		default => "yum-plugin-priorities",
	}

}
