git-packages:
  pkg.installed:
    - pkgs:
      - git

/var/local/git:
  file.directory:
    - user: root
    - group: root
