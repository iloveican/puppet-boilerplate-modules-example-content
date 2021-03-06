# == Class: filezilla::package
#
# This class exists to coordinate all software package management related
# actions, functionality and logical units in a central place.
#
#
# === Parameters
#
# This class does not provide any parameters.
#
#
# === Examples
#
# This class may be imported by other classes to use its functionality:
#   class { 'filezilla::package': }
#
# It is not intended to be used directly by external resources like node
# definitions or other modules.
#
#
# === Authors
#
# * SYN Systems <mailto:puppet@dev.syn-systems.com>
#
class filezilla::package {

  #### Package management

  # set params: in operation
  if $filezilla::ensure == 'present' {

    # Install managed packages if not present. Present packages are getting
    # upgraded by using 'latest' if there is a newer version than the present
    # one and the corresponding variable evaluates to true. The exact 'latest'
    # behavior is provider dependent. Q.v.:
    # - Puppet type reference (package, "upgradeable"): http://j.mp/xbxmNP
    # - Puppet's package provider source code: http://j.mp/wtVCaL
    $package_ensure = $filezilla::autoupgrade ? {
      true  => 'latest',
      false => 'present',
    }

  # set params: removal
  } else {

    # Remove/purge managed packages and their configuration files. The
    # exact 'purged' behavior is provider dependent. Q.v.:
    # - Puppet type reference (package, "purgeable"): http://j.mp/xbxmNP
    # - Puppet's package provider source code: http://j.mp/wtVCaL
    $package_ensure = 'purged'

  }

  # action
  package { $filezilla::package:
    ensure => $package_ensure,
  }

}
