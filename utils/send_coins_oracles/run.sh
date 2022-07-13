#!/usr/bin/env bash
pipenv run python gather_addresses.py | pipenv run python send_coins.py
