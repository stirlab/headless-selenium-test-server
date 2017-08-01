{% from 'vars.jinja' import
  test_user_password,
with context %}

x11vnc-packages:
  pkg.installed:
    - pkgs:
      - lightdm
      - xserver-xorg-video-dummy
      - x11vnc

/etc/X11/xorg.conf:
  file.managed:
    - source: salt://software/x11vnc/xorg.conf
    - mode: 644

/etc/lightdm/lightdm.conf.d/autologin.conf:
  file.managed:
    - source: salt://software/x11vnc/autologin.conf
    - mode: 644

/etc/x11vnc:
  file.directory

x11vnc-passwd:
  cmd.run:
    - name: /usr/bin/x11vnc -storepasswd "{{ test_user_password }}" /etc/x11vnc/passwd
    - creates: /etc/x11vnc/passwd
    - require:
      - pkg: x11vnc-packages
      - file: /etc/x11vnc

/etc/systemd/system/x11vnc.service:
  file.managed:
    - source: salt://software/x11vnc/x11vnc.service
    - user: root
    - group: root
    - mode: 755

systemctl-reload-x11vnc.service:
  module.run:
    - name: service.systemctl_reload
    - onchanges:
      - file: /etc/systemd/system/x11vnc.service

x11vnc-service:
  service.running:
    - name: x11vnc
    - enable: true
    - require:
      - pkg: x11vnc-packages
      - file: /etc/X11/xorg.conf
    - watch:
      - cmd: x11vnc-passwd
      - file: /etc/systemd/system/x11vnc.service

