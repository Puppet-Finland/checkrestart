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
# [*manage*]
#   Whether to manage checkrestart with Puppet or not. Valid values are 'yes' 
#   (default) and 'no'.
#
# == Examples
#
#   include checkrestart
#
# == Authors
#
# Samuli Seppänen <samuli@openvpn.net>
#
# == License
#
# BSD-license. See file LICENSE for details.
#
class checkrestart
(
    $manage = 'yes',
    $ensure = 'present'
)
{

if $manage == 'yes' {

    if $::osfamily == 'Debian' {
        class { '::debiangoodies::install':
            ensure => $ensure,
        }
    }
}
}
