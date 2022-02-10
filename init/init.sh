#!/bin/bash
set ex

apt-get update -y
apt-get install -y --no-install-recommends python3-pip
pip3 install pipenv
pipenv lock

