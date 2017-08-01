# Example pillar file for a build of a production server.
#
# The default values are found in salt/salt/vars.jinja, and can be overridden
# here.
#
# For more details on how to write pillar files, see:
# http://docs.saltstack.com/en/latest/topics/pillar

service:
  sshd:
    port: 5000
server:
  timezone: America/Denver
  alerts:
    running_too_long_timeout: 3h
