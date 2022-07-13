from urllib.request import urlopen

import json
import multiprocessing
from web3 import Web3
from web3.gas_strategies.rpc import rpc_gas_price_strategy
import os
import sys
from dotenv import load_dotenv
load_dotenv()

sk = os.environ.get("SK")
w3 = Web3(Web3.HTTPProvider('http://test.fabchain.net:8545'))

t = w3.isConnected()
if not t:
    os.exit(-1)

addr = w3.eth.account.from_key(sk).address

account_from = {
    "private_key": sk,
    "address": addr,
}

w3.eth.set_gas_price_strategy(rpc_gas_price_strategy)

def send_coins(address_to):
    tx_create = w3.eth.account.sign_transaction(
            {
                "nonce": w3.eth.get_transaction_count(
                    account_from["address"]),
                "gasPrice": w3.eth.generate_gas_price(),
                "gas": 21000,
                "to": bytes.fromhex(address_to),
                "value": w3.toWei("1", "ether"),
                "chainId": w3.eth.chain_id,
                },
            account_from["private_key"],
            )
    tx_hash = w3.eth.send_raw_transaction(tx_create.rawTransaction)
    tx_receipt = w3.eth.wait_for_transaction_receipt(tx_hash)
    print("{} {}".format(
        tx_receipt.transactionHash.hex(),
        tx_receipt.status,
    ))

def read_addresses():
    for line in sys.stdin:
        addr = line.strip()
        send_coins(addr)


if __name__ == '__main__':
    read_addresses()
