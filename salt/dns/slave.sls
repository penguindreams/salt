bind9:
    pkg:
        - installed
    service:
        - running
        - watch:
            - file: /etc/bind/named.conf.local
            - file: /etc/bind/named.conf.options

/etc/bind/named.conf.local:
    file.managed:
        - user: root
        - group: root
        - mode: 644
        - template: jinja
        - source: salt://dns/templates/named.conf.local.jinja
        - require:
            - pkg: bind9

/etc/bind/named.conf.options:
    file.managed:
        - user: root
        - group: root
        - mode: 644
        - template: jinja
        - source: salt://dns/templates/named.conf.options.jinja
        - require:
            - pkg: bind9
