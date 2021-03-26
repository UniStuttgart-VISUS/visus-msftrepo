# msftrepo

The msftrepo module installs Microsoft repository sources that in turn enable
installation of Powershell and .NET Core via a package manager.

## Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with msftrepo](#setup)
    * [What msftrepo affects](#what-msftrepo-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with msftrepo](#beginning-with-msftrepo)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Development - Guide for contributing to the module](#development)

## Description

This module installs the Microsoft production repository to RedHat or Debian systems, which provides packages like Powershell and .NET Core.

## Setup

### Setup Requirements

This module requires `puppet-yum` and `puppetlabs-apt` being installed.

### Beginning with msftrepo

Just add `include msftrepo` to add all configured repositories at their default
location.

## Usage

If desired, details of the installed repositories should be changed via Hiera.

The following global Hiera settings affect all repositories:
| Name                   | Description                                                              | Default          |
| ---------------------- | ------------------------------------------------------------------------ | ---------------- |
| `msftrepo::repo_dir`   | The path where the repository files are installed.                       |                  |
| `msftrepo::repo_owner` | The user name or UID of the user owning the repository file.             | 0                |
| `msftrepo::repo_group` | The name or UID of the group owning the repository file.                 | 0                |
| `msftrepo::key_dir`    | The directory where the key should be installed on RedHat-based systems. | /etc/pki/rpm-gpg |
| `msftrepo::key_prefix` | A prefix added to the name of the key files before the repository title. | RPM-GPG-KEY-     |

The repositories are stored in the hash `msftrepo::repos`. Each of the repositories has the following parameters:

| Name       | Description                                                 | Default                                           |
| ---------- | ----------------------------------------------------------- | ------------------------------------------------- |
| `repo_src` | The URL where the repository definition is downloaded from. | OS-dependent                                      |
| `key_id`   | The ID of the GPG key used with the repository.             | 0xEB3E94ADBE1229CF                                |
| `key_src`  | The URL where the GPG key is downloaded from.             | https://packages.microsoft.com/keys/microsoft.asc   |

## Development

Open a pull request on [GitHub](https://github.com/UniStuttgart-VISUS/visus-msftrepo/edit/main/README.md).
