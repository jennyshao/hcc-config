
node 'node000' inherits red-private {
	$role = "red-worker-el6"
	$condorCustom09 = "el6"
	include general
}


# Older Dell SC1435
node 'node063', 'node064', 'node065', 'node066', 'node067', 'node068', 'node069', 'node070', 'node071', 'node072', 'node073', 'node074', 'node075', 'node076', 'node077', 'node078', 'node079', 'node080', 'node081', 'node082', 'node083', 'node084', 'node085', 'node086', 'node087', 'node088', 'node089', 'node090', 'node091', 'node092', 'node093', 'node094', 'node095', 'node096', 'node097', 'node098', 'node099' inherits red-private {
   $role = "red-worker-el6"
	$condorCustom09 = "el6"
	$isHDFSDatanode = true
	include general
}

# rd13 Dell R710
node 'node103', 'node104', 'node105', 'node106', 'node107', 'node108', 'node109', 'node110' inherits red-private {
	$role = "red-worker-el6"
	$condorCustom09 = "el6"
	$isHDFSDatanode = true
	include general
}

# Sun X2200 M2
node 'node114', 'node115', 'node116', 'node117', 'node118', 'node119', 'node120', 'node121', 'node122', 'node123', 'node124', 'node125', 'node126', 'node127', 'node128', 'node129', 'node130', 'node131', 'node132', 'node133', 'node134', 'node135', 'node136', 'node137', 'node138', 'node139', 'node140', 'node141', 'node142', 'node143', 'node144', 'node145', 'node146', 'node147', 'node148', 'node149', 'node150', 'node151', 'node152', 'node153', 'node154', 'node155', 'node156', 'node157', 'node158', 'node159', 'node160', 'node161', 'node162', 'node163', 'node164', 'node165', 'node166', 'node167', 'node168', 'node169', 'node170', 'node171', 'node172', 'node173', 'node174', 'node175', 'node176', 'node177', 'node178', 'node179', 'node180', 'node181', 'node182', 'node183' inherits red-private {
	$role = "red-worker-el6"
   $condorCustom09 = "el6"
   $isHDFSDatanode = true
   include general
}

# KSU Tier3
node 'node189', 'node190', 'node191', 'node192', 'node193', 'node194', 'node195', 'node196', 'node197', 'node198', 'node199', 'node200' inherits red-private {
	$role = "red-worker-el6"
	$isHDFSDatanode = true
	$condorCustom09 = "el6"
	include general
}

# rd22 Dell R710
node 'node230', 'node231', 'node232', 'node233', 'node234', 'node235', 'node236', 'node237', 'node238', 'node239', 'node240', 'node241', 'node242', 'node243', 'node244', 'node245', 'node246', 'node247', 'node248', 'node249' inherits red-private {
	$role = "red-worker-el6"
	$condorCustom09 = "el6"
	$isHDFSDatanode = true
	include general
}

# Sun X4275
node 'node250', 'node251', 'node252', 'node253', 'node254' inherits red-private {
	$role = "red-worker-el6"
	$isHDFSDatanode = true
	include general
}


# ----------------------------------------------------------------------------


node 'red-d8n1', 'red-d8n2', 'red-d8n3', 'red-d8n4', 'red-d8n5', 'red-d8n6', 'red-d8n7', 'red-d8n8', 'red-d8n9', 'red-d8n10' inherits red-private {
	$role = "red-worker-el6"
   $condorCustom09 = "el6"
   $isHDFSDatanode = true
   include general
}

node 'red-d8n11', 'red-d8n12', 'red-d8n13', 'red-d8n14', 'red-d8n15', 'red-d8n16', 'red-d8n17', 'red-d8n18', 'red-d8n19', 'red-d8n20' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'red-d9n1', 'red-d9n2', 'red-d9n3', 'red-d9n4', 'red-d9n5', 'red-d9n6', 'red-d9n7', 'red-d9n8', 'red-d9n9', 'red-d9n10', 'red-d9n11', 'red-d9n12', 'red-d9n13', 'red-d9n14', 'red-d9n15', 'red-d9n16', 'red-d9n17', 'red-d9n18', 'red-d9n19', 'red-d9n20' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'red-d11n1', 'red-d11n2', 'red-d11n3', 'red-d11n4', 'red-d11n5', 'red-d11n6', 'red-d11n7', 'red-d11n8', 'red-d11n9', 'red-d11n10', 'red-d11n11', 'red-d11n12', 'red-d11n13', 'red-d11n14', 'red-d11n15', 'red-d11n16', 'red-d11n17', 'red-d11n18', 'red-d11n19', 'red-d11n20' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'red-d15n1', 'red-d15n2', 'red-d15n3', 'red-d15n4', 'red-d15n5', 'red-d15n6', 'red-d15n7', 'red-d15n8', 'red-d15n9', 'red-d15n10', 'red-d15n11', 'red-d15n12', 'red-d15n13', 'red-d15n14', 'red-d15n15', 'red-d15n16', 'red-d15n17', 'red-d15n18' inherits red-private {
	$role = "red-worker-el6"
   $condorCustom09 = "el6"
   $isHDFSDatanode = true
   include general
}

node 'red-d16n1', 'red-d16n2', 'red-d16n3', 'red-d16n4', 'red-d16n5', 'red-d16n6', 'red-d16n7', 'red-d16n8', 'red-d16n9', 'red-d16n10', 'red-d16n11', 'red-d16n12', 'red-d16n13', 'red-d16n14', 'red-d16n15', 'red-d16n16', 'red-d16n17', 'red-d16n18' inherits red-private {
	$role = "red-worker-el6"
   $condorCustom09 = "el6"
   $isHDFSDatanode = true
   include general
}

node 'red-d18n1', 'red-d18n2', 'red-d18n3', 'red-d18n4', 'red-d18n5', 'red-d18n6', 'red-d18n7', 'red-d18n8', 'red-d18n9', 'red-d18n10', 'red-d18n11', 'red-d18n12', 'red-d18n13', 'red-d18n14', 'red-d18n15', 'red-d18n16', 'red-d18n17', 'red-d18n18', 'red-d18n19', 'red-d18n20', 'red-d18n21', 'red-d18n22', 'red-d18n23', 'red-d18n24', 'red-d18n25', 'red-d18n26', 'red-d18n27', 'red-d18n28', 'red-d18n29', 'red-d18n30', 'red-d18n31', 'red-d18n32', 'red-d18n33', 'red-d18n34', 'red-d18n35', 'red-d18n36' inherits red-private {
	$role = "red-worker-el6"
   $condorCustom09 = "el6"
   $isHDFSDatanode = true
   include general
}
