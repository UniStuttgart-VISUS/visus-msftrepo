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

Just add `include msftrepo` to configure the repository. If desired, you can configure details of the installed repositories via Hiera.

## Usage

Include usage examples for common use cases in the **Usage** section. Show your
users how to use your module to solve problems, and be sure to include code
examples. Include three to five examples of the most important or common tasks a
user can accomplish with your module. Show users how to accomplish more complex
tasks that involve different types, classes, and functions working in tandem.

## Development

Open a pull request on [GitHub](https://github.com/UniStuttgart-VISUS/visus-msftrepo/edit/main/README.md).
