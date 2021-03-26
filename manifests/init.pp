# @summary Installs the Microsoft package repositories.
#
# This module installs public Microsoft package repositories containing packages
# like Powershell and .NET Core. At the moment, this module only installs the
# Microsoft production repository.
#
# @param repo_dir The directory where to install the repository file, ie
#                 "/etc/yum.repos.d" for RedHat-based systems. If not present,
#                 the module derives the path by itself.
# @param repo_owner The name or UID of the owning user of the repository file.
#                   This parameter defaults to 0 (or "root").
# @param repo_group The name or UID of the owning group of the repository file.
#                   This parameter defaults to 0 (or "root").
# @param key_dir The directory where the key should be installed. This is only
#                used on RedHat-based systems and defaults to
#                "/etc/pki/rpm-gpg".
# @param key_prefix An additional prefix string that is added before the name of
#                   the key file. This is only used on RedHat-based systems and
#                   defaults to "RPM-GPG-KEY-".
# @param repos The repositories that are being installed. The keys are the names
#              used for the individual repository files, which must be unique.
#              The values are a hash holding the parameters passed the defined
#              type "repo". This parameter is filled from Hiera.
#
# @example Include all known repositories with default configurations.
#    include visusmsft
#
# @author Christoph Müller
class msftrepo(
        Optional[String] $repo_dir = undef,
        Variant[String, Integer] $repo_owner = 0,
        Variant[String, Integer] $repo_group = 0,
        String $key_dir = '/etc/pki/rpm-gpg',
        String $key_prefix = 'RPM-GPG-KEY-',
        Hash[String, Hash[String, Variant[String, Integer, Boolean]]] $repos = {}
        ) {

    # Resolve the actual repository directory in case the user did not specify
    # an override path. For YUM, use the known path in etc, for APT, use the
    # default path from the apt module, which this module depends on.
    $actual_repo_dir = if $repo_dir {
        $repo_dir
    } else {
        case $facts['os']['family'] {
            'RedHat': { '/etc/yum.repos.d' }
            'Debian': { "${apt::params::sources_list_d}" }
            default: {
                fail(translate('The current distribution is not supported by ${title}.'))
            }
        }
    }

    $repos.each | $repo, $attributes | {
        msftrepo::repo { $repo:
            repo_dir => $actual_repo_dir,
            repo_owner => $repo_owner,
            repo_group => $repo_group,
            key_dir => $key_dir,
            key_prefix => $key_prefix,
            * => $attributes
        }
    }
}