{% from 'vars.jinja' import
  sshd_port,
with context %}

openssh-server:
  pkg.installed

sshd_config-port:
  file.line:
    - name: /etc/ssh/sshd_config
    - mode: Replace
    - match: "Port"
    - content: "Port {{ sshd_port }}"
    - require:
      - pkg: openssh-server

#sshd_config-permit-root-login:
#  file.line:
#    - name: /etc/ssh/sshd_config
#    - mode: Replace
#    - match: "PermitRootLogin"
#    - content: "PermitRootLogin yes"
#    - require:
#      - pkg: openssh-server

sshd_config-custom:
  file.append:
    - name: /etc/ssh/sshd_config
    - text:
      - "UseDNS no"
      - "GSSAPIAuthentication no"
    - require:
      - pkg: openssh-server

sshd-service:
  service.running:
    - enable: True
    - name: ssh
    - watch:
      - pkg: openssh-server
      - file: sshd_config-port
      #- file: sshd_config-permit-root-login
      - file: sshd_config-custom
