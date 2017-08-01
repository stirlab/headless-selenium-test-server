#!/bin/bash

# Example custom settings file. Copy this to settings.sh in the same directory
# to customize any of the listed installation variables. Default values are
# shown in the commented out lines.

# Directory where the Vagrantfile and development deployment scripts live. It
# will be auto-configured by the deployment script, and is included here only
# for reference.
#VAGRANT_CONFIG_DIR=

# Install path for the virtual machine. Make sure that the user executing the
# installation script has permissions to create this directory.
VM_INSTALL_DIR="/usr/local/vagrant/stirlab-webrtc-test-server"

# Directory where the salt and pillar file roots are located. This is auto
# configured by the deployement script, so unless you're doing something
# custom, it's advised not to edit it.
#SALT_DIR="`dirname $VAGRANT_CONFIG_DIR`/salt"

# The port on the host to use for connecting to the VM's SSH daemon.
SSH_PORT="2246"

