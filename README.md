# Overview

This project provides a [Salt](https://docs.saltstack.com) configuration and
supporting scripts to build out a group of headless testing servers leveraging
the [Selenium](http://www.seleniumhq.org) browser automation tool.

The repository as released provides the exact functionality used by its lead
developer for testing a [WebRTC](https://webrtc.org) application powered by
[FreeSWITCH](https://freeswitch.org) and
[Janus](https://janus.conf.meetecho.com).

It is meant to be forked as a starting point for others with similar needs.

# Key features

 * Full end user environment through [Google Chrome](https://www.google.com/chrome) automation.
 * Example [Selenium](http://www.seleniumhq.org) tests written in Python.
 * [VNC](https://en.wikipedia.org/wiki/Virtual_Network_Computing) access to the server's [Xfce](https://xfce.org) windowing environment.
 * Simulate different end user network conditions via the [PyLTC](https://github.com/yassen-itlabs/py-linux-traffic-control) traffic shaping tool.
 * Automated setup of many standard server components (firewall, network, users, etc.).
 * Local developemnt of the testing server itself via [Vagrant](https://www.vagrantup.com).

# Installation

Some familiarity with the [Salt](https://docs.saltstack.com) server
configuration tool and shell scripting is required to get the most out of this
project.

## Salt master

The master server holds the Salt configuration for the testing servers, and
must be reachable by them over the network. It can also be used to manage
staring and stopping tests on multiple testing servers.

1. Fork this repository.
1. Install a base Linux server of your favorite flavor.
1. Install the Salt master software onto the server, and use your fork's [salt](salt/salt) and [pillar](salt/pillar) configurations. You can use the provided [production/bootstrap-salt-master-server.sh](production/bootstrap-salt-master-server.sh) to perform a standard install.
1. Copy [salt/pillar/private.sls.example](salt/pillar/private.sls.example) to `salt/pillar/private.sls` and tweak to your liking.
1. Tweak [salt/pillar/production.sls](salt/pillar/production.sls) to your liking.

## Testing servers

1. Ensure the Salt master server is installed and running.
1. Install a base Linux server using the [Ubuntu Xenial LTS](http://releases.ubuntu.com/16.04) release *(other Linux flavors/releases could be used in theory, and would most likely require adjustment to the provided Salt configuration)*.
1. Copy [production/bootstrap-test-server.sh](production/bootstrap-test-server.sh) to the server.
1. Execute without arguments and follow the instructions.


## Managing tests

By default, the tests and supporting code at
[salt/salt/custom/tests](salt/salt/custom/tests) is installed to
`/home/test/tests` on all testing servers. The test running scripts discussed
below depend on finding tests in this location, with the naming pattern
`[name]_test.py`. To add/remove tests of your own, write Salt states that
place your test files in `/home/test/tests` -- see
[salt/salt/custom/tests/init.sls](salt/salt/custom/tests/init.sls) as an
example of how to do this.

Currently only Python tests are available as examples, but tests in other
languages should work fine as well, provided the correct Selenium driver for
the language is installed.

## Running tests

### From a testing server

The installed `run-test.sh`, `kill-test.sh`, and `pause-test.sh` scripts can
be used to run, kill, and pause tests directly from a testing server. They are
executed with one argument, the name of the test to run, leaving off the
`_test.py` suffix. For example, to run `foo_test.py`, execute `run-test.sh foo`.

### From the master

The [production/bootstrap-salt-master-server.sh](production/bootstrap-salt-master-server.sh)
script symlinks all scripts in [production/scripts] to `/usr/local/bin`. They
provide a simple method to manage up to ten testing servers at once, by
executing the individual test management script on multiple test servers. Edit
the `SERVER_NAME_TEMPLATE` variable at the top of each script to match the
naming pattern of the minion IDs on your testing servers, and run the script
without arguments for usage instructions.

