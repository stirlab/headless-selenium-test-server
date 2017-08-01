{% from 'vars.jinja' import
  public_eth_device,
  server_env,
  server_id,
  server_type,
with context %}

/etc/hostname:
  file:
    - managed
    - template: jinja
    - context:
      server_env: {{ server_env }}
      server_id: {{ server_id }}
    - source: salt://etc/hostname.jinja
    - user: root
    - group: root
    - mode: 644

set-hostname:
  cmd.run:
    - name: hostname {{ server_id }}
    - unless: test "$(hostname)" = "{{ server_id }}"

{% if server_type != 'vagrant' -%}
# Necessary because some DHCP servers set MTU above 1500, which causes
# problems with SSL connections.
/etc/network/interfaces:
  file.line:
    - mode: Insert
    - after: "iface {{ public_eth_device }} inet dhcp"
    - content: "post-up /sbin/ifconfig {{ public_eth_device }} mtu 1500"
{% endif -%}
