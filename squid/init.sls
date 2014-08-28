squid3:
  service:
    - running
    - enable: true    
    - reload: true
    - require:
      - pkg: squid3
    - watch:
      - pkg: squid3
  pkg:
    - installed

/etc/squid3/squid.conf:
    file.managed:
        - user: root
        - group: root
        - mode: 644
        - source: salt://squid/templates/squid.conf.jinja
        - template: jinja
        - require:
            - pkg: squid3
