FROM nvidia/cuda:11.7.0-runtime-ubuntu20.04

MAINTAINER yanorei32
EXPOSE 8080
WORKDIR /init

COPY Pipfile Pipfile.lock /init

ENV LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
ENV CC="gcc -O3 -mtune=znver1"

RUN set ex; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		python3 python3-pip zlib1g libjpeg-turbo8 libgomp1 git unzip wget curl vim zsh; \
	savedAptMark="$(apt-mark showmanual)"; \
	apt-get install -y --no-install-recommends \
		python3-dev zlib1g-dev libjpeg-dev gcc; \
	pip3 install pipenv; \
	pipenv install --system; \
	apt-mark auto '.*' > /dev/null; \
	[ -z "$savedAptMark" ] || apt-mark manual $savedAptMark; \
	apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
	rm -rf /var/lib/apt/lists/*; \
	chsh -s /bin/zsh

WORKDIR /root

CMD [ \
	"jupyter", \
	"notebook", \
	"--port", "8080", \
	"--allow-root", \
	"--ip=0.0.0.0", \
	"--NotebookApp.token=password", \
	"--NotebookApp.allow_origin=*" ]
