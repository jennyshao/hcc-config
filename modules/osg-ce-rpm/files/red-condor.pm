##############################################################################
##############################################################################
#
#	DO NOT EDIT - file is being maintained by puppet
#
##############################################################################
##############################################################################


# Globus::GRAM::JobManager::condor package

use Globus::GRAM::Error;
use Globus::GRAM::JobState;
use Globus::GRAM::JobManager;
use Globus::GRAM::StdioMerger;
use Globus::Core::Paths;

use Config;
eval { require Globus::GRAM::JobManager::condor_accounting_groups };
our $accounting_groups_callout = ! $@; # Don't make callout if we couldn't load module

# NOTE: This package name must match the name of the .pm file!!
package Globus::GRAM::JobManager::condor;

@ISA = qw(Globus::GRAM::JobManager);
$ENV{CONDOR_CONFIG} = '/etc/condor/condor_config';

my ($condor_submit, $condor_rm);

BEGIN
{
    $condor_submit 	= '/usr/bin/condor_submit';
    $condor_rm	 	= '/usr/bin/condor_rm';
}

sub new
{
    my $proto = shift;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new(@_);
    my $log_dir;
    my $description = $self->{JobDescription};
    my $stdout = $description->stdout();
    my $stderr = $description->stderr();
    my $globus_condor_conf = "$ENV{GLOBUS_LOCATION}/etc/globus-condor.conf";

    # We want to have individual Condor log files for each job for
    # pre-WS GRAM, but still have a single log file for WS GRAM
    # (which uses the SEG to monitor job status).
    if ( !defined( $description->factoryendpoint() ) ) {
	$self->{individual_condor_log} = 1;
    } else {
	$self->{individual_condor_log} = 0;
    }

    if (-r $globus_condor_conf)
    {
        local(*FH);

        if (open(FH, "<$globus_condor_conf"))
        {
            while(<FH>) {
                chomp;
                if (m/log_path=(.*)$/) {
                    $self->{condor_logfile} = $1;
                    break;
                }
            }
            close(FH);
        }
    }
    if (! exists($self->{condor_logfile}) || $self->{individual_condor_log})
    {
        if(! exists($ENV{GLOBUS_SPOOL_DIR}))
        {
            $log_dir = $Globus::Core::Paths::tmpdir;
        }
        else
        {
            $log_dir = $ENV{GLOBUS_SPOOL_DIR};
        }
	if ( $self->{individual_condor_log} ) {
	    $self->{condor_logfile} = "$log_dir/gram_condor_log."
		. $description->uniq_id();
	} else {
	    $self->{condor_logfile} = "$log_dir/gram_condor_log";
	}
    }
    if ((! -e $self->{condor_logfile}) && ($self->{individual_condor_log} == 0)) 
    {
        # We make sure that the log file exists with the correct 
        # permissions. If we just let Condor create it, it will
        # have 664 permissions, and when another user submits a job
        # they will be unable to write to the log file. We create the 
        # file in append mode to avoid a race condition, in case
        # multiple instantiations of this script open and write
        # to the log file. 
        if ( open(CONDOR_LOG_FILE, '>>' . $self->{condor_logfile}) ) 
        {
            close(CONDOR_LOG_FILE);
        }
        chmod(0666, $self->{condor_logfile});
    }

    if($description->jobtype() eq 'multiple' && $description->count > 1)
    {
        $self->{STDIO_MERGER} =
            new Globus::GRAM::StdioMerger($self->job_dir(), $stdout, $stderr);
    }
    else
    {
        $self->{STDIO_MERGER} = 0;
    }



    bless $self, $class;
    return $self;
}

sub submit
{
    my $self = shift;
    my $description = $self->{JobDescription};
    my @environment;
    my $environment_string;
    my $script_filename;
    my $error_filename;
    my $requirements = '';
    my $rank = '';
    my @arguments;
    my $argument_string;
    my %library_vars;
    my @response_text;
    my @submit_attrs;
    my $submit_attrs_string;
    my $multi_output = 0;
    my $failure_text = '';

    my $isNFSLite = 1; # Flag to tell if we are using NFS lite. 1 or true for yes
    my $scratch_isset = 0; # Flag if the SCRATCH_DIRECTORY environment variable is set indicating likely GRAM job
    

    # Reject jobs that want streaming, if so configured
    if ( $description->streamingrequested() &&
	 $description->streamingdisabled() ) {

	$self->log("Streaming is not allowed.");
	return Globus::GRAM::Error::OPENING_STDOUT;
    }

    if($description->jobtype() eq 'single' ||
       $description->jobtype() eq 'multiple')
    {
	$universe = 'vanilla';

        if ($description->jobtype() eq 'multiple'
                && ($description->count() > 1)) {
            $multi_output = 1;
        }
    }
    elsif($description->jobtype() eq 'condor')
    {
	$universe = 'standard'
    }
    else
    {
	return Globus::GRAM::Error::JOBTYPE_NOT_SUPPORTED();
    }

    # Validate some RSL parameters
    if(!defined($description->directory()))
    {
        return Globus::GRAM::Error::RSL_DIRECTORY;
    }
    elsif( $description->stdin() eq '')
    {
	return Globus::GRAM::Error::RSL_STDIN;
    }
    elsif(ref($description->count()) ||
       $description->count() != int($description->count()))
    {
	return Globus::GRAM::Error::INVALID_COUNT();
    }
    elsif( $description->executable eq '')
    {
	return Globus::GRAM::Error::RSL_EXECUTABLE();
    }

    # In the standard universe, we can validate stdin and directory
    # because they will sent to the execution host  by condor transparently.
    if($universe eq 'standard')
    {
	if(! -d $description->directory())
	{
	    return Globus::GRAM::Error::BAD_DIRECTORY;
	}
	elsif(! -r $description->stdin())
	{
	    return Globus::GRAM::Error::STDIN_NOT_FOUND();
	}
	elsif(! -f $description->executable())
	{
	    return Globus::GRAM::Error::EXECUTABLE_NOT_FOUND();
	}
	elsif(! -x $description->executable())
	{
	    return Globus::GRAM::Error::EXECUTABLE_PERMISSIONS();
	}
    }

    $library_vars{LD_LIBRARY_PATH} = 0;
    if($Config{osname} eq 'irix')
    {
	$library_vars{LD_LIBRARYN32_PATH} = 0;
	$library_vars{LD_LIBRARY64_PATH} = 0;
    }
    @environment = $description->environment();
    foreach $tuple (@environment)
    {
	if(!ref($tuple) || scalar(@$tuple) != 2)
	{
	    return Globus::GRAM::Error::RSL_ENVIRONMENT();
	}
	if(exists($library_vars{$tuple->[0]}))
	{
	    $tuple->[1] .= ":$library_string";
	    $library_vars{$tuple->[0]} = 1;
	}
    }

    ##### OSG-Specific modification                 #####
    ##### These should not affect any non-OSG site, #####
    ##### unless you define $OSG_GRID               #####

    # First, we figure out if this is an OSG installation, and if so, where 
    # OSG is installed on the worker nodes
    my $osg_grid = '';
    my $use_osg_grid = 1;
    my $use_dynamic_wn_tmp = 1;
    map {
        if ($_->[0] eq "OSG_GRID") {
            $osg_grid =  $_->[1]; 
        } elsif ($_->[0] eq "OSG_DONT_USE_OSG_GRID_FOR_GL") {
            $use_osg_grid = 0;
        }
        
    } @environment;

    # If this is an OSG installation, we set GLOBUS_LOCATION based on OSG_GRID,
    # and we set OSG_WN_TMP based on _CONDOR_SCRATCH_DIR
    if ($osg_grid ne '') {
        map {
            if ($use_osg_grid && $_->[0] eq "GLOBUS_LOCATION") { 
                $_->[1] = $osg_grid . "/globus"; 
            }
        } @environment;
    }
    ##### End OSG-Specific modification             #####


    foreach (keys %library_vars)
    {
        my $library_path = join(':', $description->library_path());

	if($library_vars{$_} == 0)
	{
	    push(@environment, [$_, $library_path]);
	}
    }
    $environment_string = join(';',
                               map {$_->[0] . "=" . $_->[1]} @environment);

    @arguments = $description->arguments();
    foreach (@arguments)
    {
	if(ref($_))
	{
	    return Globus::GRAM::Error::RSL_ARGUMENTS();
	}
    }
    if($#arguments >= 0)
    {
	$argument_string = join(' ',
				map
				{
				    $_ =~ s/"/\\\"/g; #"
				    $_;
				}
				@arguments);
    }
    else
    {
	$argument_string = '';
    }

    @submit_attrs = $description->condorsubmit();
    if(defined($submit_attrs[0]))
    {
	foreach $tuple (@submit_attrs)
	{
	    if(!ref($tuple) || scalar(@$tuple) != 2)
	    {
		return Globus::GRAM::Error::RSL_SCHEDULER_SPECIFIC();
	    }
	}
	$submit_attrs_string = join("\n",
				map {$_->[0] . "=" . $_->[1]} @submit_attrs);
    }
    else
    {
	$submit_attrs_string = '';
    }

    my $group;
    if ($accounting_groups_callout) {
       $group = Globus::GRAM::JobManager::condor_accounting_groups::obtain_condor_group(\@environment, $self);
    }
    # Create script for condor submission
    $script_filename = $self->job_dir() . '/scheduler_condor_submit_script';

    $error_filename = $self->job_dir() . '/scheduler_condor_submit_stderr';

    local(*SCRIPT_FILE);

    open(SCRIPT_FILE, ">$script_filename") 
        or return Globus::GRAM::Error::TEMP_SCRIPT_FILE_FAILED;

    print SCRIPT_FILE "#\n# description file for condor submission\n#\n";
    print SCRIPT_FILE "Universe = $universe\n";
    print SCRIPT_FILE "Notification = Never\n";
    if ($description->directory() =~ m|^[^/]|)
    {
        my $home = (getpwuid($<))[7];

        $description->add('directory', "$home/".$description->directory());
    }
    if ($description->executable() =~ m|^[^/]|)
    {
        $description->add('executable',
                $description->directory() . '/' . $description->executable());
    }

    print SCRIPT_FILE "Executable = " . $description->executable . "\n";

    $requirements  = "OpSys == \"" . $description->condor_os() . "\" ";
    $requirements .= " && Arch == \"" . $description->condor_arch() . "\" ";
    if($description->min_memory() ne '')
    {
	$requirements .= " && Memory >= " . $description->min_memory();
	$rank = "rank = Memory\n";
    }

    print SCRIPT_FILE "Requirements = $requirements\n";
    if($rank ne '')
    {
	print SCRIPT_FILE "$rank\n";
    }

    if ($ENV{X509_USER_PROXY} ne "") {
        print SCRIPT_FILE "X509UserProxy = $ENV{X509_USER_PROXY}\n";
    }
    print SCRIPT_FILE "Environment = $environment_string\n";
    print SCRIPT_FILE "Arguments = $argument_string\n";
    print SCRIPT_FILE "InitialDir = " . $description->directory() . "\n";
    print SCRIPT_FILE "Input = " . $description->stdin() . "\n";
    print SCRIPT_FILE "Log = " . $self->{condor_logfile} . "\n";
    print SCRIPT_FILE "log_xml = True\n";
# Patched by the VDT
    print SCRIPT_FILE "+GratiaJobOrigin=\"GRAM\"\n";
# End VDT patch
    print SCRIPT_FILE "#Extra attributes specified by client\n";
    print SCRIPT_FILE "$submit_attrs_string\n";

    if ($accounting_groups_callout && $group) {
	$name = getpwuid($>);
	print SCRIPT_FILE "+AccountingGroup = \"$group.$name\"\n" if $group;
    }

    for (my $i = 0; $i < $description->count(); $i++) {
        if ($multi_output) {
            print SCRIPT_FILE "Output = " .
                    $self->{STDIO_MERGER}->add_file('out') . "\n";
            print SCRIPT_FILE "Error = " .
                    $self->{STDIO_MERGER}->add_file('err') . "\n";
        } else {
            print SCRIPT_FILE "Output = " . $description->stdout() . "\n";
            print SCRIPT_FILE "Error = " . $description->stderr() . "\n";
        }
        print SCRIPT_FILE "queue 1\n";
    }

    close(SCRIPT_FILE);

    $self->log("About to submit condor job");
    local(*FH);
    my $pid = open(FH, "-|");
    if( !defined($pid))
    {
        # failure to fork
        $failure_text = "fork: $!\n";
    }
    elsif ($pid)
    {
        my $rc = 0;

        $self->log("I am the parent");
        # parent
        @response_text = <FH>;
        $rc = close(FH);

        if ((!$rc) && $! == 0) {
            $self->log("submission failed!!!");
            # condor submission failed with non-zero exit code
            $self->nfssync( $error_filename, 0);

            if ($rc == 127 && $response_text[0] =~ m/^exec: /) {
                # exec failed
                $self->log("exec failed\n");
                $failure_text = join(//, @response_text);
                @response_text = ();
            } elsif (-s $error_filename) {
                $self->log("Error file is not empty, and submission failed\n");
                # condor_submit stderr is in $error_filename, we'll use that
                # as our extended error info
                local(*ERR);
                open(ERR, "<$error_filename");
                local($/);
                $failure_text = <ERR>;
                $self->log("Error text is $failure_text");
                close(ERR);
                @response_text = ();
            } else {
                $self->log("Error file is empty, and submission failed\n");
            }
        } else {
            $self->log("\$rc = $rc, \$! = $!");
        }
    }
    else
    {
        # child
        open (STDERR, '>' . $error_filename);
        select(STDERR); $| = 1;
        select(STDOUT); $| = 1;

        if (! exec { $condor_submit } $condor_submit, $script_filename)
        {
            print "exec: $!\n";
            exit(127);
        }
    }

    if (@response_text)
    {
        if ($failure_text ne '') {
            $self->log("Strange, $failure_text is defined!");
        }
	$response_line =(grep(/submitted to cluster/, @response_text))[0];
	$job_id = (split(/\./, (split(/\s+/, $response_line))[5]))[0];

	if($job_id ne '')
	{
	    $status = Globus::GRAM::JobState::PENDING;

            if ($description->emit_condor_processes()) {
                $job_id = join(',', map { sprintf("%03d.%03d.%03d",
                        $job_id, $_, 0) } (0..($description->count()-1)));
            }
	    return {JOB_STATE => Globus::GRAM::JobState::PENDING,
		    JOB_ID    => $job_id};
	}
    } elsif ($failure_text ne '') {
        $self->log("Writing extended error information to stderr");
        local(*ERR);
        open(ERR, '>' . $description->stderr());
        print ERR $failure_text;
        close(ERR);

        $failure_text =~ s/\n/\\n/g;

        $self->respond({GT3_FAILURE_MESSAGE => $failure_text });
    }
    return Globus::GRAM::Error::JOB_EXECUTION_FAILED;
}

sub poll
{
    my $self = shift;
    my $description = $self->{JobDescription};
    my $state;
    my $job_id = $description->job_id();
    my ($cluster, $proc, $subproc) = ($job_id, 0, 0);
    my $num_done;
    my $num_run;
    my $num_evict;
    my $num_abort;

    $self->log("polling job " . $description->jobid());

    if (! $description->emit_condor_processes()) {
        local(*CONDOR_LOG_FILE);

        if ( open(CONDOR_LOG_FILE, '<' . $self->{condor_logfile}) )
        {
            while (<CONDOR_LOG_FILE>)
            {
                if (/<c>/) {
                    if (defined($record)) {
                        if ($record->{Cluster} == $cluster)
                        {
                            # record Matches our job id
                            if ($record->{EventTypeNumber} == 1)
                            {
                                # execute event
                                $num_run++;
                            } elsif ($record->{EventTypeNumber} == 4) {
                                $num_evict++;
                            } elsif ($record->{EventTypeNumber} == 5) {
                                $num_done++;
                            } elsif ($record->{EventTypeNumber} == 9) {
                                $num_abort++;
                            }
                        }
                    } 
                    $record = {};
                } elsif (/<a n="([^"]+)">/) { #"/) {
                    my $attr = $1;

                    if (/<s>([^<]+)<\/s>/) {
                        $record->{$attr} = $1;
                    } elsif (/<i>([^<]+)<\/i>/) {
                        $record->{$attr} = int($1);
                    } elsif (/<b v="([tf])"\/>/) {
                        $record->{$attr} = ($1 eq 't');
                    } elsif (/<r>([^<]+)<\/r>/) {
                        $record->{$attr} = $1;
                    }
                } elsif (/<\/c>/) {
                }
            }

            if (defined($record)) {
                if ($record->{Cluster} == $cluster)
                {
                    # record Matches our job id
                    if ($record->{EventTypeNumber} == 1)
                    {
                        # execute event
                        $num_run++;
                    } elsif ($record->{EventTypeNumber} == 4) {
                        $num_evict++;
                    } elsif ($record->{EventTypeNumber} == 5) {
                        $num_done++;
                    } elsif ($record->{EventTypeNumber} == 9) {
                        $num_abort++;
                    }
                }
            } 
            @status = grep(/^[0-9]* \(0*${job_id}/, <CONDOR_LOG_FILE>);
            close(CONDOR_LOG_FILE);
        }
        else
        {
            $self->nfssync( $description->stdout(), 0 )
                if $description->stdout() ne '';
            $self->nfssync( $description->stderr(), 0 )
                if $description->stderr() ne '';

            # Should we really delete a file that we have not
            # been able to read.  This leaves room for a race 
            # condition So the following code is commented out:

            #if ( ${self}->{individual_condor_log} ) {
            #    $self->log_to_gratia();
            #    unlink($self->{condor_logfile});
            #}
            return { JOB_STATE => Globus::GRAM::JobState::DONE };
        }

        if($num_abort > 0)
        {
            # Don't delete the condor log when not reporting DONE
            return Globus::GRAM::Error::SYSTEM_CANCELLED();
        }
        elsif($num_done == $description->count())
        {
            $self->nfssync( $description->stdout(), 0 )
                if $description->stdout() ne '';
            $self->nfssync( $description->stderr(), 0 )
                if $description->stderr() ne '';

            if ( ${self}->{individual_condor_log} ) {
                $self->log_to_gratia();
                unlink($self->{condor_logfile});
            }
            $state = Globus::GRAM::JobState::DONE;
        }
        elsif($num_run == 0)
        {
            $state = Globus::GRAM::JobState::PENDING;
        }
        elsif($num_run > $num_evict)
        {
            $state = Globus::GRAM::JobState::ACTIVE;
        }
        else
        {
            $state = Globus::GRAM::JobState::SUSPENDED;
        }
    }
    else
    {
        $state = Globus::GRAM::JobState::DONE;
    }


    if($self->{STDIO_MERGER}) {
        $self->{STDIO_MERGER}->poll($state == Globus::GRAM::JobState::DONE);
    }

    return { JOB_STATE => $state };
}

sub cancel
{
    my $self = shift;
    my $description = $self->{JobDescription};
    my $job_id = $description->jobid();
    my $count = 0;

    $job_id =~ s/,/ /g;
    $job_id =~ s/(\d+\.\d+)\.\d+/$1/g;

    $self->log("cancel job " . $description->jobid());
    # we do not need to be too efficient here
    $self->log(`$condor_rm $job_id 2>&1`);

    if($? == 0)
    {
	return { JOB_STATE => Globus::GRAM::JobState::FAILED };
    }
    else
    {
	return Globus::GRAM::Error::JOB_CANCEL_FAILED();
    }
}

# Patched by the VDT
sub log_to_gratia
{
    my $self = shift;
    my $log_filename = $self->{condor_logfile};

    # Select the gratia location
    my $env = "$ENV{VDT_LOCATION}";
    if ( "x$env" eq "x" ) {
      $env = "$ENV{GLOBUS_LOCATION}/..";
    }
    if ( "x$env" eq "x" ) {
       $env = "/var/tmp";
    }
    my $log_dir = "$env/gratia/var/data/";
    
    if ( -d $log_dir ) {
      # For now assume that the existence of the directory means that
      # accounting is enabled.
      if ( -r $log_filename ) {
         $self->log("Logging for accounting purpose the file $log_filename into $log_dir");
         @args = ("cp", "$log_filename" , "$log_dir" );
         system(@args) == 0 or $self->log("Error: system @args failed: $?");
      } else {
         if ( ! -e $log_filename ) {
            $self->log("Logging for accounting purpose failed: $log_filename does not exist");
         } else {
            $self->log("Logging for accounting purpose failed: can not read the file $log_filename");
         }
         return 0; # should return a proper Globus failure code.
      }
    }
    return 1; # Should return a proper Globus success code
}

sub cache_cleanup
{
    my $self = shift;
    my $description = $self->{JobDescription};

    if ( ${self}->{individual_condor_log} ) {
        $self->log("Deleting Condor user log");
        $self->log_to_gratia();
        unlink($self->{condor_logfile});
    }

    return $self->SUPER::cache_cleanup($self);
}


1;
