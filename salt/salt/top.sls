base:
  '*':
    - early-packages
    - update-packages
    - base-packages
    - service.firewall
    - service.network
    - auth.root
    - auth.test
    - service.ssh
    - misc
    - software.git
    - software.x11vnc
    - software.xfce
    - software.chromium
    - software.selenium
    - software.pyltc
    - service.salt-minion
    - service.ntp
    # Disabled by default.
    #- service.browsermob-proxy
    - custom
    - ignore_missing: True

