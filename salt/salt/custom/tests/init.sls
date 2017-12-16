{% from 'vars.jinja' import
  public_eth_device,
  pyltc_git_checkout,
  server_test_access_key,
with context %}

include:
  - auth.test

/home/test/tests/tc_map.py:
  file.managed:
    - source: salt://custom/tests/tc_map.py
    - user: root
    - group: root
    - mode: 644
    - require:
      - file: /home/test/tests

/home/test/tests/user_map.py:
  file.managed:
    - source: salt://custom/tests/user_map.py
    - user: root
    - group: root
    - mode: 644
    - require:
      - file: /home/test/tests

/home/test/tests/test_common.py:
  file.managed:
    - source: salt://custom/tests/test_common.py.jinja
    - template: jinja
    - context:
      public_eth_device: {{ public_eth_device }}
      pyltc_git_checkout: {{ pyltc_git_checkout }}
    - user: root
    - group: root
    - mode: 644
    - require:
      - file: /home/test/tests

/home/test/tests/test_config.py:
  file.managed:
    - source: salt://custom/tests/test_config.py.jinja
    - template: jinja
    - context:
      server_test_access_key: {{ server_test_access_key }}
    - user: root
    - group: root
    - mode: 644
    - require:
      - file: /home/test/tests

/home/test/tests/main_room_test.py:
  file.managed:
    - source: salt://custom/tests/main_room_test.py
    - user: root
    - group: root
    - mode: 755
    - require:
      - file: /home/test/tests

/home/test/tests/main_room_two_feeds_test.py:
  file.managed:
    - source: salt://custom/tests/main_room_two_feeds_test.py
    - user: root
    - group: root
    - mode: 755
    - require:
      - file: /home/test/tests

/home/test/tests/main_room_three_feeds_test.py:
  file.managed:
    - source: salt://custom/tests/main_room_three_feeds_test.py
    - user: root
    - group: root
    - mode: 755
    - require:
      - file: /home/test/tests

/home/test/tests/main_room_four_feeds_test.py:
  file.managed:
    - source: salt://custom/tests/main_room_four_feeds_test.py
    - user: root
    - group: root
    - mode: 755
    - require:
      - file: /home/test/tests

/home/test/tests/main_room_six_feeds_test.py:
  file.managed:
    - source: salt://custom/tests/main_room_six_feeds_test.py
    - user: root
    - group: root
    - mode: 755
    - require:
      - file: /home/test/tests

/home/test/tests/breakout_test.py:
  file.managed:
    - source: salt://custom/tests/breakout_test.py
    - user: root
    - group: root
    - mode: 755
    - require:
      - file: /home/test/tests

/home/test/tests/breakout_two_test.py:
  file.managed:
    - source: salt://custom/tests/breakout_two_test.py
    - user: root
    - group: root
    - mode: 755
    - require:
      - file: /home/test/tests

/home/test/tests/breakout_four_test.py:
  file.managed:
    - source: salt://custom/tests/breakout_four_test.py
    - user: root
    - group: root
    - mode: 755
    - require:
      - file: /home/test/tests

/home/test/tests/multi_breakout_test.py:
  file.managed:
    - source: salt://custom/tests/multi_breakout_test.py
    - user: root
    - group: root
    - mode: 755
    - require:
      - file: /home/test/tests

/home/test/tests/multi_breakout_four_test.py:
  file.managed:
    - source: salt://custom/tests/multi_breakout_four_test.py
    - user: root
    - group: root
    - mode: 755
    - require:
      - file: /home/test/tests

