{% from 'vars.jinja' import
  server_env,
with context -%}

{% set service_status = server_env == 'production' and 'running' or 'disabled' %}

salt-minion-service:
  service.{{ service_status }}:
    - name: salt-minion
{% if server_env == 'production' %}
    - enable: True
{% endif %}
