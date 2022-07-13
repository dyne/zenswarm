from urllib.request import urlopen

import json
import os
import sys
from dotenv import load_dotenv
load_dotenv()

def gather_addresses():
    # Oracles addresses
    url = "https://did.dyne.org/api/W3C-DID-extract-oracles-uid.chain"

    response = urlopen(url)

    data_json = json.loads(response.read())

    for d in data_json['W3C-DIDs_uid_list']:
        # print('{}/api/zenswarm-oracle-get-identity'.format(d))
        try:
            response = urlopen('{}/api/zenswarm-oracle-get-identity'.format(d))
            identity = json.loads(response.read())
            print(identity['identity']['ethereum_address'])
        except:
            print(d, file=sys.stderr)


if __name__ == '__main__':
    # send_coins("0x7f206ab48751dae5ca94a0bf82f0c01e2382d5a6")
    gather_addresses()
