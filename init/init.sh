#!/bin/bash
set -eux

pip3 install --no-cache-dir -r requirements.txt

pipenv lock
