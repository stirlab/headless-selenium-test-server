base-packages:
  pkg.installed:
    - pkgs:
      - aptitude
      - bash-completion
      - colordiff
      - dbus
      - file
      - htop
      - libpam-systemd
      - logwatch
      - lynx
      - man-db
      - mutt
      - patch
      - patchutils
      # Needed for pkgrepo Salt state.
      - python-apt
      - tcpdump
      - telnet
      - tmux
      - traceroute
      - unzip
      - vim
    - order: 3

