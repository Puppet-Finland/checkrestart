#
# == Class: checkrestart
#
# Install a tool for checking if any of the running processes are using files 
# from packages that have been upgraded.
#
# Use checkrestart::cron to automate the checks and for emailing the results.
#
# == Parameters
#
# None at the moment
#
# == Examples
#
# include checkrestart
#
# == Authors
#
# Samuli Seppänen <samuli@openvpn.net>
#
# == License
#
# BSD-lisence
# See file LICENSE for details
#
class checkrestart
(
    $status = 'present'
)
{

# Rationale for this is explained in init.pp of the sshd module
if hiera('manage_checkrestart', 'true') != 'false' {

    if $::osfamily == 'Debian' {
        class { 'debiangoodies::install':
            status => $status,
        }
    }
}
}
