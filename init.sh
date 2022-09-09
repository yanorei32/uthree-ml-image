#!/bin/bash

set -eux

apt-get update -qq -y

# https://repology.org/project/[PACKAGE]/versions
# https://packages.ubuntu.com/focal/[PACKAGE]
# https://packages.ubuntu.com/source/focal/[PACKAGE]
# https://launchpad.net/ubuntu/+source/[PACKAGE]

# depName=ubuntu_22_04/python3-defaults
PYTHON3_VERSION="3.10.4-0ubuntu2"

# depName=ubuntu_22_04/zlib
ZLIB_VERSION="1:1.2.11.dfsg-2ubuntu9"

# depName=ubuntu_22_04/libjpeg-turbo
LIBJPEGTURBO_VERSION="2.1.2-0ubuntu1"

# depName=ubuntu_22_04/gcc-10
GCC_VERSION="10.3.0-1ubuntu1~20.04"

# depName=ubuntu_22_04/git
GIT_VERSION="1:2.34.1-1ubuntu1.4"

# depName=ubuntu_22_04/unzip
UNZIP_VERSION="6.0-26ubuntu3"

# depName=ubuntu_22_04/wget
WGET_VERSION="1.21.2-2ubuntu1"

# depName=ubuntu_22_04/curl
CURL_VERSION="7.81.0-1ubuntu1.4"

# depName=ubuntu_22_04/vim
VIM_VERSION="2:8.2.3995-1ubuntu2"

# depName=ubuntu_22_04/zsh
ZSH_VERSION="5.8.1-1"

# depName=ubuntu_22_04/make-dfsg
MAKE_VERSION="4.3-4.1build1"

# depName=ubuntu_22_04/openssl
OPENSSL_VERSION="3.0.2-0ubuntu1.6"

# depName=ubuntu_22_04/bzip2
BZIP2_VERSION="1.0.8-5build1"

# depName=ubuntu_22_04/ncurses
NCURSES_VERSION="6.3-2"

# depName=ubuntu_22_04/libffi
LIBFFI_VERSION="3.4.2-4"

# depName=ubuntu_22_04/readline
READLINE_VERSION="8.1.2-1"

# depName=ubuntu_22_04/sqlite3
SQLITE3_VERSION="3.37.2-2"

# depName=ubuntu_22_04/lzma
LZMA_VERSION="9.22-2.2"

apt-get install -qq -y --no-install-recommends \
	"python3=$PYTHON3_VERSION" \
	"zlib1g=$ZLIB_VERSION" \
	"libjpeg-turbo8=$LIBJPEGTURBO_VERSION" \
	"libgomp1=$GCC_VERSION" \
	"git=$GIT_VERSION" \
	"unzip=$UNZIP_VERSION" \
	"wget=$WGET_VERSION" \
	"curl=$CURL_VERSION" \
	"vim=$VIM_VERSION" \
	"zsh=$ZSH_VERSION" \
	"openssl=$OPENSSL_VERSION" \
	"libbz2-1.0=$BZIP2_VERSION" \
	"libncurses5=$NCURSES_VERSION" \
	"libffi7=$LIBFFI_VERSION" \
	"libreadline8=$READLINE_VERSION" \
	"libsqlite3-0=$SQLITE3_VERSION" \
	"lzma=$LZMA_VERSION"

# depName=pyenv/pyenv
PYENV_RELEASE="v2.3.4"

savedAptMark="$(apt-mark showmanual)"

apt-get install -qq -y --no-install-recommends \
	"python3-dev=$PYTHON3_VERSION" \
	"zlib1g-dev=$ZLIB_VERSION" \
	"libjpeg-turbo8-dev=$LIBJPEGTURBO_VERSION" \
	"gcc-10=$GCC_VERSION" \
	"make=$MAKE_VERSION" \
	"libssl-dev=$OPENSSL_VERSION" \
	"libbz2-dev=$BZIP2_VERSION" \
	"libncurses5-dev=$NCURSES_VERSION" \
	"libffi-dev=$LIBFFI_VERSION" \
	"libreadline-dev=$READLINE_VERSION" \
	"libsqlite3-dev=$SQLITE3_VERSION" \
	"lzma-dev=$LZMA_VERSION"

export CFLAGS='-O3 -mtune=znver1'
export CC='gcc-10'

git clone https://github.com/pyenv/pyenv \
	--depth=1 --branch "$PYENV_RELEASE" \
	/usr/local/pyenv

(cd /usr/local/pyenv && src/configure && make -C src -j "$(nproc)")

{
	# shellcheck disable=SC2016
	echo 'export PYENV_ROOT="/usr/local/pyenv"'

	# shellcheck disable=SC2016
	echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"'

	# shellcheck disable=SC2016
	echo 'eval "$(pyenv init -)"'
} >> /usr/local/pyenv/pyenv-init

chmod +x /usr/local/pyenv/pyenv-init

set +eux

# shellcheck disable=SC1091
. /usr/local/pyenv/pyenv-init

set -eux

pyenv install "$(cat .python-version)"
pyenv global "$(cat .python-version)"

pip3 install --no-cache-dir -r requirements.txt

pipenv install --system

apt-mark auto '.*' > /dev/null

# shellcheck disable=SC2086
[[ -z "$savedAptMark" ]] || apt-mark manual $savedAptMark

apt-get purge -y --auto-remove \
	-o APT::AutoRemove::RecommendsImportant=false

rm -rf /var/lib/apt/lists/*
