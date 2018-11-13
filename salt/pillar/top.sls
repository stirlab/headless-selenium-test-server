base:
  'server:group:test-server':
    - match: grain
    - server.common
    - ignore_missing: True
  # This allows extending the Salt configuration for different environments.
  'G@server:group:test-server and G@server:env:development':
    - match: compound
    - server.development
    - server.private
  'G@server:group:test-server and G@server:env:production':
    - match: compound
    - server.production
    - server.private

