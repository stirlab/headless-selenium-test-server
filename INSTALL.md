## Salt master

The master server holds the Salt configuration for the testing servers, and
must be reachable by them over the network. It can also be used to manage
starting and stopping tests on multiple testing servers.

 1. Fork this repository.
 1. Install a base Linux server of your favorite flavor.
 1. Install the Salt master software onto the server, and use your fork's [salt](salt/salt) and [pillar](salt/pillar) configurations. You can use the provided [production/bootstrap-salt-master-server.sh](production/bootstrap-salt-master-server.sh) to perform a standard install.
 1. Copy [salt/pillar/server/private.sls.example](salt/pillar/server/private.sls.example) to `salt/pillar/private.sls` and tweak to your liking.
 1. Tweak [salt/pillar/production.sls](salt/pillar/production.sls) to your liking.

## Testing servers

 1. Ensure the Salt master server is installed and running.
 1. Install a base Linux server using the [Ubuntu Xenial LTS](http://releases.ubuntu.com/16.04) release *(other Linux flavors/releases could be used in theory, and would most likely require adjustment to the provided Salt configuration)*.
 1. Copy the [production/bootstrap-test-server.sh](production/bootstrap-test-server.sh) script to the server.
 1. Execute the script without arguments and follow the instructions.
 1. On a new installation, you'll need to log into the testing server once to enable auto-login:
   * The default password can be found in [salt/salt/vars.jinja](salt/salt/vars.jinja), and is used for all logins described below.
   * Use a VNC client to log into the server, port 5900.
   * Log into the desktop.
