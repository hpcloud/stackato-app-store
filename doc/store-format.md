A Stackato App Store is a server that returns app info as JSON.

In Stackato 1.2 a static JSON file is all you need for this. When stores get very large, an App Store search API may be defined.

This repo contains static YAML files that get turned into static JSON files to be served to the Stackato Management Console (SMC).

The information in any of the .yaml files, should be self explanatory, but this document attempts document it.

This document defines the model of this JSON structure. Annotated YAML is used:

    # The Store is a hash with 2 keys: 'store' and 'apps'. 'store' contains
    # meta info about the store itself. 'apps' is an array of app hashes:
    store:
      title: Human Friendly Title of This App Store
      contact: Email address of App Store Maintainer
      icon: URL of icon for the App Store to display in the SMC
      icons: Base URL of directory for icons. If this exists, 'icon' can be
        just a file name.

    # The fields used in each 'app' are all required:
    apps:
    - id: A unique id for app. Should be lowercase alphanumeric (dashes and
        underscores ok).
      name: Human Friendly Name
      desc: Short one-lin description of app
      framework: App framework (perl, python, ruby, etc)
      license: Software License of App
      mem: Memory Requirements in MB
      repo: URL of git repo where the app code resides
      home: Web page (usually github page with #readme) of the doc for the app
      icon: URL of icon for the App
      services: An array of services matching what is specified in the stackato.yml
