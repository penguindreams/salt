# Plato manages the dns client configuration during the bootstrap phase
# After that it's easier to manage via resolvconf
remove_plato_dns_servers:
    file.replace:
        - name: /etc/network/interfaces
        - pattern: 'dns-nameservers.*'
        - repl: ''
remove_plato_dns_search:
    file.replace:
        - name: /etc/network/interfaces
        - pattern: 'dns-search.*'
        - repl: ''

# Ubuntu resolv.conf is using resolvconf
/etc/resolv.conf:
    file.symlink:
        - target: /run/resolvconf/resolv.conf
        - force: True

# This gets regenerated on boot, so this is just making sure
# any manually applied changes get reverted
/run/resolvconf/resolv.conf:
    file.managed:
        - user: root
        - group: root
        - mode: 644
        - template: jinja
        - source: salt://dns/templates/resolv.conf.jinja

/etc/resolvconf/resolv.conf.d/base:
    file.managed:
        - user: root
        - group: root
        - mode: 644
        - template: jinja
        - source: salt://dns/templates/resolvconf/resolv.conf.d/base.jinja

/etc/resolvconf/resolv.conf.d/head:
    file.managed:
        - user: root
        - group: root
        - mode: 644
        - template: jinja
        - source: salt://dns/templates/resolvconf/resolv.conf.d/head.jinja

/etc/resolvconf/resolv.conf.d/tail:
    file.managed:
        - user: root
        - group: root
        - mode: 644
        - template: jinja
        - source: salt://dns/templates/resolvconf/resolv.conf.d/tail.jinja
