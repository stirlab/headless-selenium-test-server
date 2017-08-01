The testing server itself can be installed locally for development using the
instructions below:

 1. Install [Git](http://git-scm.com), [Vagrant](https://www.vagrantup.com) and [VirtualBox](https://www.virtualbox.org). OS X [Homebrew](http://brew.sh) users, consider easy installation via [Homebrew Cask](http://caskroom.io).
 1. Clone your fork of the headless-selenium-test-server project to the host machine.
 1. Clone [PyLTC](https://github.com/yassen-itlabs/py-linux-traffic-control) to the host machine.
 1. In the `vagrant` directory, you'll find `settings.sh.example`. Copy that file in the same directory to `settings.sh`, and edit to taste.
 1. Tweak [salt/pillar/development.sls](salt/pillar/development.sls) to your liking.
 1. From the command line, run `vagrant/development-environment-init.sh`.
 1. Once the script successfully completes the pre-flight checks, it will automatically handle the rest of the installation and setup. Relax, grab a cup of chai, and watch the setup process roll by on screen. :)
 1. If the setup script finds an SSH pubkey in the default location of the host's HOME directory, it will automatically install that pubkey to the VM. The end of the script outputs optional configuration you can add to your `.ssh/config` file, to enable easy root SSH access to the server.
 1. The installed virtual machine can be controlled like any other Vagrant VM. See [this Vagrant cheat sheet](http://notes.jerzygangi.com/vagrant-cheat-sheet) for more details.
 1. If for any reason the installation fails, or you just want to completely remove the installed virtual machine, run the `vagrant/kill-development-environment.sh` script from the command line.

