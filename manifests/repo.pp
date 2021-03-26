# @summary (Un-) Installs a repository along with its GPG key.
#
# @param repo_src The URL of the repositoy definition, ie the file to be copied
#                 to "/etc/yum.repos.d".
# @param repo_dir The directory where to install the repository file, ie
#                 "/etc/yum.repos.d" for RedHat-based systems.
# @param repo_owner The name or UID of the owning user of the repository file.
# @param repo_group The name or UID of the owning group of the repository file.
# @param key_id The ID of the GPG key used by the repository.
# @param key_src The URL of the GPG key to be installed.
# @param key_dir The directory where the key should be installed. This is only
#                used on RedHat-based systems.
# @param key_prefix An additional prefix string that is added before the
#                   name of the key file. This is only used on RedHat-based
#                   systems.
# @param ensure Determines whether the repository should be present or absent.
#               This defaults to "present".
#
# @author Christoph Müller
define msftrepo::repo(
        String $repo_src,
        String $repo_dir,
        String $repo_ext,
        Variant[String, Integer] $repo_owner,
        Variant[String, Integer] $repo_group,
        String $key_id,
        String $key_src,
        String $key_dir,
        String $key_prefix,
        String $ensure = present,
        ) {

    # Determine the extension of the repository file from the source's name.
    $repo_ext = if $attributes[repo_src] =~ /(\.[^\.]+)$/ {
        "$0"
    } else {
        ''
    }

    case $facts['os']['family'] {
        'RedHat': {
            # (Un-) Install the repository GPG key.
            unless ($repo_src == undef) {
                yum::gpgkey { "$key_dir/${key_prefix}${title}":
                    ensure => $ensure,
                    source => $key_src,
                }
            }

            # Resolve the target path for the repo definition.
            $dst = if $repo_dir {
                $repo_dir
            } else {
                '/etc/yum.repos.d'
            }

            # (Un-) Install the repo definition.
            file { "${dst}/${title}.${repo_ext}":
                ensure => $ensure,
                source => $repo_src,
                owner => $repo_owner,
                group => $repo_group,
            }
        }

        'Debian': {
            # (Un-) Install the repository GPG key.
            apt::key { $title:
                ensure => $ensure,
                id => $key_id,
                source => $key_src
            }

            # Resolve the target path for the repo definition.
            $dst = if $repo_dir {
                $repo_dir
            } else {
                "${apt::params::sources_list_d}"
            }

            # (Un-) Install the repo definition.
            file { "${dst}/${title}.${repo_ext}":
                ensure => $ensure,
                source => $repo_src,
                owner => $repo_owner,
                group => $repo_group
            }
            -> exec { 'refresh-after-${title}':
                command => "${apt::params::provider} update"
            }
        }

        default: {
            fail(translate('The current distribution is not supported by ${title}.'))
        }
    }
}
