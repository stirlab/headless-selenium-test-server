{% from 'vars.jinja' import
  ssh_pubkeys_root,
with context %}

{% for user, data in ssh_pubkeys_root.iteritems() %}
sshkey-{{ user }}:
  ssh_auth:
    - present
    - user: root
    - enc: {{ data.enc|default('ssh-rsa') }}
    - name: {{ data.key }}
    - comment: {{ user }}
{% endfor %}

/root/.bashrc.d:
  file.directory:
    - user: root
    - group: root
    - dir_mode: 755

/root/bin:
  file.directory:
    - user: root
    - group: root
    - dir_mode: 755

/usr/local/bin/run-test.sh:
  file.managed:
    - source: salt://auth/root/run-test.sh
    - user: root
    - group: root
    - mode: 755
    - require:
      - file: /root/bin

/usr/local/bin/pause-test.sh:
  file.managed:
    - source: salt://auth/root/pause-test.sh
    - user: root
    - group: root
    - mode: 755
    - require:
      - file: /root/bin

/usr/local/bin/kill-test.sh:
  file.managed:
    - source: salt://auth/root/kill-test.sh
    - user: root
    - group: root
    - mode: 755
    - require:
      - file: /root/bin

