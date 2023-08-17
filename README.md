# apt repository over http proxy playgroud

This project aim to play with a `http proxy` that is used as a `apt repository`.
For now this project is based on `ubuntu:20.04` but it can work for any *debian based*
distribution.

## Requirements

- [`docker`](https://www.docker.com/)

## Getting started

First you must launch containers:

```bash
$ ./scripts/up.sh
Creating network "custom-apt-repository-playgroud_default" with the default driver
Creating custom-apt-repository-playgroud_ubuntu-20-04_1 ... done
Creating custom-apt-repository-playgroud_repository_1   ... done

WARNING: apt does not have a stable CLI interface. Use with caution in scripts.

Ign:1 http://repository generic/ InRelease
Ign:2 http://repository generic/ Release
Get:3 http://repository generic/ Packages [270 B]
Get:4 http://archive.ubuntu.com/ubuntu focal InRelease [265 kB]
Get:5 http://security.ubuntu.com/ubuntu focal-security InRelease [114 kB]
Get:6 http://archive.ubuntu.com/ubuntu focal-updates InRelease [114 kB]
...
```

Then you must create debian-package and configure repository:

```bash
$ ./scripts/build-debian-package.sh
dpkg-deb: building package 'fake-debian' in 'fake-debian.deb'.
dpkg-scanpackages: warning: Packages in archive but missing from override file:
dpkg-scanpackages: warning:   fake-debian
dpkg-scanpackages: info: Wrote 1 entries to output Packages file.
```

Now, you can test the newly created repository:

```bash
$ ./scripts/enter-in-ubuntu-container.sh
root@89f552b3ea9e:/workdir# apt update
Ign:1 http://repository generic/ InRelease
Ign:2 http://repository generic/ Release
Get:3 http://repository generic/ Packages [272 B]
Hit:4 http://security.ubuntu.com/ubuntu focal-security InRelease
Hit:5 http://archive.ubuntu.com/ubuntu focal InRelease
Hit:6 http://archive.ubuntu.com/ubuntu focal-updates InRelease
Hit:7 http://archive.ubuntu.com/ubuntu focal-backports InRelease
Fetched 272 B in 0s (582 B/s)
Reading package lists... Done
Building dependency tree
Reading state information... Done
All packages are up to date.
```

And finally installed `fake-debian` (the debian-package created before):

```bash
root@89f552b3ea9e:/workdir# apt install fake-debian
Reading package lists... Done
Building dependency tree
Reading state information... Done
The following NEW packages will be installed:
  fake-debian
0 upgraded, 1 newly installed, 0 to remove and 0 not upgraded.
Need to get 760 B of archives.
After this operation, 0 B of additional disk space will be used.
Get:1 http://repository generic/ fake-debian 1.0 [760 B]
Fetched 760 B in 0s (0 B/s)
debconf: delaying package configuration, since apt-utils is not installed
Selecting previously unselected package fake-debian.
(Reading database ... 6782 files and directories currently installed.)
Preparing to unpack .../fake-debian_1.0_all.deb ...
Unpacking fake-debian (1.0) ...
Setting up fake-debian (1.0) ...
root@89f552b3ea9e:/workdir# fake-debian
fake-debian working!
```

## Clean project

If you want to clean project and save resources, you can use:

```bash
$ docker-compose down
```

## Licence

[MIT](./LICENSE)
