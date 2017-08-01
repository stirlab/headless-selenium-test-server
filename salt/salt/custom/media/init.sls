include:
  - auth.test

/home/test/media/sample-audio.wav:
  file.managed:
    - source: http://s3.amazonaws.com/stirlab-resources/sample-audio.wav
    - source_hash: md5=f03ae2d9efbde39fffb7dd070160d129
    - user: root
    - group: root
    - mode: 644
    - require:
      - file: /home/test/media

/home/test/media/sample-vid.y4m:
  file.managed:
    - source: http://s3.amazonaws.com/stirlab-resources/sample-vid.y4m
    - source_hash: md5=0076228eb5806b75c80547e6156131bb
    - user: root
    - group: root
    - mode: 644
    - require:
      - file: /home/test/media

