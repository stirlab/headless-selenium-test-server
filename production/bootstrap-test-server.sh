#!/usr/bin/env bash

# Bootstraps the repository and installs Salt.

PROJECT_NAME="headless-selenium-test-server"
SALT_GIT_TAG="v2017.7.3"

echo -n "Enter the host name for this server: "
read HOSTNAME

echo -n "Enter the host name for the Salt master server: "
read SALT_MASTER_HOSTNAME

apt-get update
apt-get -y install git
cd /tmp/
git clone https://github.com/stirlab/${PROJECT_NAME}.git
cd && wget -O install_salt.sh https://bootstrap.saltstack.com && sh install_salt.sh -X -d git ${SALT_GIT_TAG} && systemctl stop salt-minion.service
rm install_salt.sh
cp /tmp/${PROJECT_NAME}/production/salt/minion /etc/salt/
sed -i.bak "s%###SALT_MINION_ID###%${HOSTNAME}%g" /etc/salt/minion
rm /etc/salt/minion.bak
sed -i.bak "s%###SALT_MASTER_HOSTNAME###%${SALT_MASTER_HOSTNAME}%g" /etc/salt/minion
rm /etc/salt/minion.bak
mkdir -p /etc/salt/minion.d
cp /tmp/${PROJECT_NAME}/production/salt/grains.conf /etc/salt/minion.d/
rm -r /tmp/${PROJECT_NAME}

echo "Starting salt-minion service..."
systemctl start salt-minion.service

echo "Log into Salt master ${SALT_MASTER_HOSTNAME} and run the following command:

salt-key -a ${HOSTNAME}

Press any key to continue once the key has been accepted on the master."

read -n 1 -s PROCEED

echo "Running highstate..."
salt-call state.highstate

echo "
If you see no error messages, the bootstrap was successful.
"
exit 0
