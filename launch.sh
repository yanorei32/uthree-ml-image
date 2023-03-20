#!/bin/bash

# shellcheck disable=SC1091
. /usr/local/pyenv/pyenv-init

jupyter notebook \
	--port 8080 \
	--allow-root \
	--ip=0.0.0.0 \
	--NotebookApp.token='' \
	--no-browser
