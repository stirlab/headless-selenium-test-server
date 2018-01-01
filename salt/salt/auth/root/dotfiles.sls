include:
  - software.git

/root/dotfiles:
  file.directory:
    - user: root
    - group: root
    - mode: 755

dotfiles-git:
  git.latest:
    - name: https://github.com/thehunmonkgroup/dotfiles.git
    - rev: master
    - target: /root/dotfiles
    - require:
      - pkg: git-packages
      - file: /root/dotfiles

dotfiles-var-db:
  file.directory:
    - name: /var/db
    - user: root
    - group: root

# Copying files here allows listening for onchanges to only trigger
# other states when these files are changed.
/var/db/dotfiles-config:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - require:
      - file: /var/db

/var/db/dotfiles-config/default.conf.yaml:
  file.managed:
    - source: /root/dotfiles/config/default.conf.yaml
    - user: root
    - group: root
    - mode: 644
    - require:
      - file: /var/db/dotfiles-config
      - git: dotfiles-git

update-dotfiles:
  cmd.run:
    - name: ./install
    - cwd: /root/dotfiles
    - env:
      - HOME: /root
    - use_vt: True
    - onchanges:
      - file: /var/db/dotfiles-config/default.conf.yaml

/var/db/dotfiles-config/git-repositories:
  file.managed:
    - source: /root/dotfiles/git-repositories
    - user: root
    - group: root
    - mode: 644
    - require:
      - file: /var/db/dotfiles-config
      - git: dotfiles-git

/root/.vim:
  file.directory:
    - user: root
    - group: root
    - mode: 755

/root/.vim/bundle:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - require:
      - file: /root/.vim

update-dotfiles-git-repositories:
  cmd.run:
    - name: /root/dotfiles/bootstrap-git-repos.sh -c /var/db/dotfiles-config/git-repositories
    - env:
      - HOME: /root
    - use_vt: True
    - require:
      - file: /root/.vim/bundle
    - onchanges:
      - file: /var/db/dotfiles-config/git-repositories
