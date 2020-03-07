#!/usr/bin/env python3

import argparse
import subprocess

from urllib.parse import urlparse

BASE_CONFIG = """internal: 127.0.0.1 port = 8081
external: eth0
clientmethod: none
socksmethod: none

user.privileged: root
user.unprivileged : nobody

client pass {
    from: 0.0.0.0/0 to: 0.0.0.0/0
    log: connect disconnect error
    pam.servicename: sockd
}

socks pass {
    from: 0.0.0.0/0 to: 0.0.0.0/0
    log: connect disconnect error
}
"""

PROXY_CONFIG = """route {{
    from: 0.0.0.0/0 to: 0.0.0.0/0 via: {hostname} port = {port}
    proxyprotocol: {protocol}
	command: connect
	protocol: tcp
    method: none
}}
"""

DANTE_CONFIG_PATH = '/etc/danted.conf'

PROTOCOL_MAPPING = {
    'socks': 'socks_v4 socks_v5',
    'socks4': 'socks_v4',
    'socks5': 'socks_v5',
}

if __name__ == '__main__':
    parser = argparse.ArgumentParser('Set a dante proxy and reload the service')
    parser.add_argument('proxy', nargs='?', help='Define proxy server to use')

    args = parser.parse_args()

    if args.proxy:
        proxy_parsed = urlparse(args.proxy)
        protocol = PROTOCOL_MAPPING[proxy_parsed.scheme]
        port = proxy_parsed.port
        hostname = proxy_parsed.hostname

        proxy_config = PROXY_CONFIG.format(hostname=hostname, port=port, protocol=protocol)
    else:
        proxy_config = None

    with open(DANTE_CONFIG_PATH, 'w') as f:
        f.write(BASE_CONFIG)
        if proxy_config:
            f.write(proxy_config)

    try:
        subprocess.check_call(['pkill', 'danted'])
    except subprocess.CalledProcessError:
        pass

    try:
        subprocess.check_call(['/etc/init.d/danted', 'restart'])
    except subprocess.CalledProcessError:
        pass
