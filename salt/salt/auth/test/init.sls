{% from 'vars.jinja' import
  test_user_password_hashed,
with context %}

test-group:
  group.present:
    - name: test

test-user:
  user.present:
    - name: test
    - gid_from_name: True
    - fullname: "Test user"
    - password: "{{ test_user_password_hashed }}"
    - shell: /bin/bash
    - require:
      - group: test-group

/etc/sudoers.d/test_user:
  file.managed:
    - source: salt://etc/sudoers.d/test_user
    - user: root
    - group: root
    - mode: 440

/home/test/.Xauthority:
  file.managed:
    - source: salt://auth/test/Xauthority
    - user: test
    - group: test
    - mode: 600
    - require:
      - group: test-group
      - user: test-user

/home/test/media:
  file.directory

/home/test/tests:
  file.directory

/home/test/logs:
  file.directory
