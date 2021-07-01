# My own Debian Distribution

You can create your own Debian distribution from scratch with live-build. Here you will find a few steps to create a full functional Debian distribution with your packages, repositories, files and basic configuration.

## Requirements

First of all, you need a VM with Debian installed (I'm using VirtualBox and a minimal Debian Buster).

Then, the only package you need is live-build. You can install via:

```shell
apt-get install live-build
```

## First step

In this repository, there is a folder called 'auto' where you will find some scripts to help you.

First of all, you must edit 'auto/config' with your own configuration. Then, launch it and automatically will be generated the necesary tree structure folder.

Then, to test if your configuration is ok, then launch 'auto/build' to start all proccess. The result will be an iso file with a minimal Debian distribution.

## Install packages from Debian repository

Under path 'config/package-lists' you can create files with name packages to install in your distribution. You will find an example on file 'config/package-lists/my.list.chroot_install'.

See more information in https://live-team.pages.debian.net/live-manual/html/live-manual/customizing-package-installation.en.html#387

## Add GPG keys, third party repositories and install third party packages

There are multiple ways to add third party repositories. I had problems with CA certs using one of them, so I add keys in one way and repositories in other way.

To install keys, you can add it on folder 'config/archives' directly or you can export it from your XXX using commands:

```shell
apt-key list # Get list of keys
apt-key adv -k # Get keys id
apt-key adv -o config/archives/<name>.key.chroot --export <key id>
```

To add third party repositories and install packages, you can add your scripts on path 'config/hooks/live/'. There is an example on path 'config/hooks/live/install.hook.chroot' with added some third party repositories, install packages from this repositories and compile python 3.9.5-

## Install packages .deb without repository

You can add deb packages placing it on folder 'config/packages.chroot/' and they will be installed automatically.

## Add custom files or override system files

You can place your own files with your configuration just on folder 'config/includes.chroot/' with real tree structure starting from root. 

You have some examples placed there.

## Chromium initial configuration

Chromium is just an example on how to fix some configuration from beginning. On path 'config/includes.chroot/etc/chromium/master_preferences' there is a file with that configuration.

Here you can place configuration like bookmarks by default (you can export your bookmarks on a HTML file and reference it), extensions installed by default, etc...

## Gnome configuration

I like to custom Gnome configuration but on each format I loose some configuration. You can add it by default on your distribution and always will be there with you.

I usually install my Debian distribution, export configuration to a file, custom my gnome configuration, export again and compare with initial config.

To do that you can use these commands:

```shell
dconf dump / > <file> # Export gnome configuration
glib-compile-schemas /usr/share/glib-2.0/schemas/ # Generate file gschemas.compiled
```

All files, including 'gschemas.compiled', must be placed on path 'config/includes.chroot/usr/share/glib-2.0/schemas/'. You have some examples on my repository.

Note: Take care with dconf tool, it dumps configuration with slash references and you must replace with dot references: 

```[org/gnome/shell] -> [org.gnome.shell]```

## References

- https://manpages.debian.org/jessie/live-build/live-build.7.en.html
- https://live-team.pages.debian.net/live-manual/html/live-manual/index.en.html
- https://live-team.pages.debian.net/live-manual/html/live-manual/customizing-package-installation.en.html#387
