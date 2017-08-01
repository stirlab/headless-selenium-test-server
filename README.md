## Overview

This project provides a [Salt](https://docs.saltstack.com) configuration and
supporting scripts to build out a group of headless testing servers leveraging
the [Selenium](http://www.seleniumhq.org) browser automation tool.

The repository as released provides the exact functionality used by its lead
developer for testing a [WebRTC](https://webrtc.org) application powered by
[FreeSWITCH](https://freeswitch.org) and
[Janus](https://janus.conf.meetecho.com). You can see some examples of the
tool in action [here](https://www.youtube.com/watch?v=V4PBWXKi-WQ) and
[here](https://www.youtube.com/watch?v=km6a8DVsKUA).

It is meant to be forked as a starting point for others with similar needs.


## Key features

 * Full end user environment through [Google Chrome](https://www.google.com/chrome) automation.
 * Example [Selenium](http://www.seleniumhq.org) tests written in Python.
 * [VNC](https://en.wikipedia.org/wiki/Virtual_Network_Computing) access to the server's [Xfce](https://xfce.org) windowing environment.
 * Simulate different end user network conditions via the [PyLTC](https://github.com/yassen-itlabs/py-linux-traffic-control) traffic shaping tool.
 * Automated setup of many standard server components (firewall, network, users, etc.).
 * Local developemnt of the testing server itself via [Vagrant](https://www.vagrantup.com).


## Installation

Some familiarity with the [Salt](https://docs.saltstack.com) server
configuration tool and shell scripting is required to get the most out of this
project.

See [INSTALL.md](INSTALL.md) for details.


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

Some generally useful testing helpers can be found in
[salt/salt/custom/tests/test_common.py.jinja](salt/salt/custom/tests/test_common.py.jinja),
including those related to traffic shaping via
[PyLTC](https://github.com/yassen-itlabs/py-linux-traffic-control)


## Running tests

### From a testing server

The installed `run-test.sh`, `kill-test.sh`, and `pause-test.sh` scripts can
be used to run, kill, and pause tests directly from a testing server. They are
executed with one argument, the name of the test to run, leaving off the
`_test.py` suffix. For example, to run `foo_test.py`, execute `run-test.sh foo`.

### From the master

The [production/bootstrap-salt-master-server.sh](production/bootstrap-salt-master-server.sh)
script symlinks all scripts in [production/scripts](production/scripts) to `/usr/local/bin`. They
provide a simple method to manage up to ten testing servers at once, by
executing the individual test management script on multiple test servers. Edit
the `SERVER_NAME_TEMPLATE` variable at the top of each script to match the
naming pattern of the minion IDs on your testing servers, and run the script
without arguments for usage instructions.


## Miscellaneous

 * Everything under the [salt/salt/custom](salt/salt/custom) directory are resources specifically used by the lead developer in their testing environment. They are included in the repository for convenience, and can be used or removed as needed without compromising the overall functionality of the server.


## Support

The issue tracker for this project is provided to file bug reports, feature requests, and project tasks -- support requests are not accepted via the issue tracker. For all support-related issues, including configuration, usage, and training, consider hiring a competent consultant.

