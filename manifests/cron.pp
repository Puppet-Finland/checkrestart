#
# == Class: checkrestart::cron
#
# Configure checkrestart to run from cron
#
# == Parameters
#
# [*status*]
#   Status of the cronjob. Valid values 'present' and 'absent'. Defaults to 
#   'present'.
# [*hour*]
#   Hour(s) when the agent gets run. Defaults to 8 (8 AM).
# [*minute*]
#   Minute(s) when the agent gets run. Defaults to 20.
# [*weekday*]
#   Weekday(s) when the agent gets run. Defaults to * (all weekdays).
# [*email*]
#   Email address where notifications are sent. Defaults to top-scope variable 
#   $::servermonitor.
#
# == Examples
#
#   class { 'checkrestart::cron':
#       hour => '3',
#       minute => '35'
#       weekday => '1-5',
#   }
#
class checkrestart::cron(
    $status = 'present',
    $hour = '8',
    $minute = '20',
    $weekday = '*',
    $email = $::servermonitor
)
{

# Rationale for this is explained in init.pp of the sshd module
if hiera('manage_checkrestart', 'true') != 'false' {

    include checkrestart

    if $::osfamily == 'Debian' {

        # Only send email if something is out of date. As checkrestart does not set 
        # the return value based on it's results, we need to do some grep magic.
        $cron_command = "checkrestart|grep -v \"Found 0 processes using old versions of upgraded files\""

        cron { 'checkrestart-cron':
            ensure => $status,
            command => $cron_command,
            user => root,
            hour => $hour,
            minute => $minute,
            weekday => $weekday,
            environment => [ 'PATH=/sbin:/usr/sbin:/bin:/usr/bin', "MAILTO=${email}" ],
        }
    }
}
}
