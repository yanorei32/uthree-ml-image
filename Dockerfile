FROM nvidia/cuda:11.8.0-runtime-ubuntu22.04@sha256:bdc36b424bc051fd005c41c69c83bd2af22d82171d43410e3554ae2e16c84256

LABEL maintainer="yanorei32"
EXPOSE 8080

COPY Pipfile Pipfile.lock requirements.txt init.sh .python-version /init/

ENV LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH

WORKDIR /init
RUN ./init.sh

WORKDIR /root
RUN rm -rf /init

COPY launch.sh /

CMD [ "/launch.sh" ]
