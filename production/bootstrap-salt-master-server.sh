#!/usr/bin/env bash

# Bootstraps the Salt master server.

SALT_GIT_TAG="v2017.7.0"
PROJECT_NAME="headless-selenium-test-server"
INSTALL_DIR="/var/local/git"
FULL_INSTALL_PATH="${INSTALL_DIR}/${PROJECT_NAME}"
LOCAL_BIN_DIR="/usr/local/bin"

echo -n "Enter the host name for this server: "
read HOSTNAME

echo -n "Enter the full URL of the ${PROJECT_NAME} repository to clone: "
read GIT_CLONE_URL

echo "Updating necessary software..."
apt-get update
apt-get -y install git

echo "Ensuring ${INSTALL_DIR}"
mkdir -p ${INSTALL_DIR}


echo "Cloning ${GIT_CLONE_URL} into ${INSTALL_DIR}..."
cd ${INSTALL_DIR}
git clone ${GIT_CLONE_URL}

echo "Configuring Salt..."
mkdir -p /srv && cd /srv && ln -s ${FULL_INSTALL_PATH}/salt
cd /tmp && wget -O install_salt.sh https://bootstrap.saltstack.com && sh install_salt.sh -M git ${SALT_GIT_TAG} && rm install_salt.sh
cp ${FULL_INSTALL_PATH}/production/salt/master /etc/salt/
sed -i.bak "s%###SALT_MASTER_ID###%${HOSTNAME}%g" /etc/salt/master
rm /etc/salt/master.bak
systemctl restart salt-master.service

SCRIPTS=`ls -1 ${FULL_INSTALL_PATH}/production/scripts`

cd ${LOCAL_BIN_DIR}
for script in $SCRIPTS; do
  echo "Symlinking ${script} to ${LOCAL_BIN_DIR}"
  ln -s ${FULL_INSTALL_PATH}/production/scripts/${script}
done

echo "Done!"

exit 0

