{% from 'vars.jinja' import
  alert_running_too_long_timeout,
  sendgrid_api_key,
  server_alert_emails,
with context %}

{% if sendgrid_api_key != "" and server_alert_emails|length > 0 and alert_running_too_long_timeout != "" %}
# Quick hack to allow alerting if a server is up too long.
/etc/rc.local:
  file.managed:
    - source: salt://etc/rc.local
    - user: root
    - group: root
    - mode: 755

/usr/local/bin/server_running_too_long.sh:
  file.managed:
    - source: salt://custom/alerts/server_running_too_long.sh.jinja
    - template: jinja
    - context:
      sendgrid_api_key: {{ sendgrid_api_key }}
      server_alert_emails: {{ server_alert_emails }}
      alert_running_too_long_timeout: {{ alert_running_too_long_timeout }}
    - user: root
    - group: root
    - mode: 700
{% endif %}

