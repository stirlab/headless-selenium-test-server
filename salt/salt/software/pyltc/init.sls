{% from 'vars.jinja' import
  public_eth_device,
  pyltc_git_checkout,
  pyltc_git_checkout_dependency,
  pyltc_git_branch,
  pyltc_git_url,
  server_type
with context %}

{{ pyltc_git_checkout }}:
  file.directory:
    - user: root
    - group: root
    - dir_mode: 755

{% if server_type != 'vagrant' -%}
pyltc-git-checkout:
  git.latest:
    - name: {{ pyltc_git_url }}
    - rev: {{ pyltc_git_branch }}
    - target: {{ pyltc_git_checkout }}
    - force_checkout: True
    - force_reset: True
    - require:
      - file: {{ pyltc_git_checkout }}
{% endif -%}

/etc/pyltc.profiles:
  file.managed:
    - source: salt://software/pyltc/pyltc.profiles.jinja
    - template: jinja
    - context:
      public_eth_device: {{ public_eth_device }}
    - mode: 644

/usr/local/bin/pyltc:
  file.symlink:
    - target: {{ pyltc_git_checkout }}/ltc.py
    - require:
      - {{ pyltc_git_checkout_dependency }}
