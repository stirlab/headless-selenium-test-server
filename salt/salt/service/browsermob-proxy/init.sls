{% from 'vars.jinja' import
  browsermob_proxy_archive_hash,
  browsermob_proxy_port,
  browsermob_proxy_version,
with context %}

include:
  - software.java

browsermob-proxy-archive:
  archive.extracted:
    - name: /usr/local/
    - source: https://github.com/lightbody/browsermob-proxy/releases/download/browsermob-proxy-{{ browsermob_proxy_version }}/browsermob-proxy-{{ browsermob_proxy_version }}-bin.zip
    - source_hash: md5={{ browsermob_proxy_archive_hash }}
    - archive_format: zip
    - if_missing: /usr/local/browsermob-proxy-{{ browsermob_proxy_version }}/

browsermob-proxy-executable:
  file.managed:
    - name: /usr/local/browsermob-proxy-{{ browsermob_proxy_version }}/bin/browsermob-proxy
    - mode: 755
    - require:
      - archive: browsermob-proxy-archive

/etc/systemd/system/browsermob-proxy.service:
  file.managed:
    - source: salt://service/browsermob-proxy/browsermob-proxy.service.jinja
    - template: jinja
    - context:
      browsermob_proxy_port: {{ browsermob_proxy_port }}
      browsermob_proxy_version: {{ browsermob_proxy_version }}
    - user: root
    - group: root
    - mode: 755

systemctl-reload-browsermob-proxy.service:
  module.run:
    - name: service.systemctl_reload
    - onchanges:
      - file: /etc/systemd/system/browsermob-proxy.service

browsermob-proxy-service:
  service.running:
    - name: browsermob-proxy
    - enable: true
    - require:
      - pkg: java-packages
      - archive: browsermob-proxy-archive
      - file: browsermob-proxy-executable
    - watch:
      - file: /etc/systemd/system/browsermob-proxy.service

