class role_red-gridftp {

   include general
   include users
   include autofs
   include pam
   include openssh
   include sudo
   include nrpe
   include ganglia
   include ganglia::diskstat
   include hostcert
   include gridftp-hdfs
   include xrootd

}
