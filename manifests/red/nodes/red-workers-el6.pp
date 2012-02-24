
node /^red-d1[5,6]n\d+\.red\.hcc\.unl\.edu$/ inherits red-private {
	$isHDFSDatanode = true
   $condorCustom09 = "el6"
   $role = "red-worker-el6"

	include general
   include cvmfs
   include chroot
   include osg-wn-client
#	include yum

   yumrepo { "nebraska-el6":
      baseurl => "http://t2.unl.edu/store/repos/nebraska/6/nebraska-el6/x86_64/",
      descr => "Nebraska EL6 Packages",
      enabled => 1,
      gpgcheck => 0,
      http_caching => none,
      priority => "97",
   }
   yumrepo { "osg-release":
      baseurl => "http://red-web.unl.edu/osg/3.0/el6/osg-release/x86_64/",
      descr => "osg-release",
      enabled => 1,
      gpgcheck => 0,
      http_caching => none,
     priority => "98",
   }
   yumrepo { "osg-testing":
      baseurl => "http://red-web.unl.edu/osg/3.0/el6/osg-testing/x86_64/",
      descr => "osg-testing",
      enabled => 1,
      gpgcheck => 0,
      http_caching => none,
      priority => "98",
   }
   yumrepo { "osg-development":
      baseurl => "http://red-web.unl.edu/osg/3.0/el6/osg-development/x86_64/",
      descr => "osg-development",
      enabled => 1,
      gpgcheck => 0,
      http_caching => none,
      priority => "98",
   }
}



node /^red-d18n\d+\.red\.hcc\.unl\.edu$/ inherits red-private {
	$isHDFSDatanode = false
   $condorCustom09 = "el6"
   $role = "red-worker-el6"

	include general
   include cvmfs
   include chroot
   include osg-wn-client
#	include yum

   yumrepo { "nebraska-el6":
      baseurl => "http://t2.unl.edu/store/repos/nebraska/6/nebraska-el6/x86_64/",
      descr => "Nebraska EL6 Packages",
      enabled => 1,
      gpgcheck => 0,
      http_caching => none,
      priority => "97",
   }
   yumrepo { "osg-release":
      baseurl => "http://red-web.unl.edu/osg/3.0/el6/osg-release/x86_64/",
      descr => "osg-release",
      enabled => 1,
      gpgcheck => 0,
      http_caching => none,
     priority => "98",
   }
   yumrepo { "osg-testing":
      baseurl => "http://red-web.unl.edu/osg/3.0/el6/osg-testing/x86_64/",
      descr => "osg-testing",
      enabled => 1,
      gpgcheck => 0,
      http_caching => none,
      priority => "98",
   }
   yumrepo { "osg-development":
      baseurl => "http://red-web.unl.edu/osg/3.0/el6/osg-development/x86_64/",
      descr => "osg-development",
      enabled => 1,
      gpgcheck => 0,
      http_caching => none,
      priority => "98",
   }
}


node /^red-d18n19.red.hcc.unl.edu$/ inherits red-private {
	$isHDFSDatanode = false 
   $condorCustom09 = "el6"
   $role = "red-worker-el6"

	include general
   include cvmfs
   include chroot
   include osg-wn-client
#	include yum

   yumrepo { "nebraska-el6":
      baseurl => "http://t2.unl.edu/store/repos/nebraska/6/nebraska-el6/x86_64/",
      descr => "Nebraska EL6 Packages",
      enabled => 1,
      gpgcheck => 0,
      http_caching => none,
      priority => "97",
   }
   yumrepo { "osg-release":
      baseurl => "http://red-web.unl.edu/osg/3.0/el6/osg-release/x86_64/",
      descr => "osg-release",
      enabled => 1,
      gpgcheck => 0,
      http_caching => none,
     priority => "98",
   }
   yumrepo { "osg-testing":
      baseurl => "http://red-web.unl.edu/osg/3.0/el6/osg-testing/x86_64/",
      descr => "osg-testing",
      enabled => 1,
      gpgcheck => 0,
      http_caching => none,
      priority => "98",
   }
   yumrepo { "osg-development":
      baseurl => "http://red-web.unl.edu/osg/3.0/el6/osg-development/x86_64/",
      descr => "osg-development",
      enabled => 1,
      gpgcheck => 0,
      http_caching => none,
      priority => "98",
   }
}
