FROM nvidia/cuda:12.1.0-runtime-ubuntu22.04@sha256:89939ce962f064194be862ce572b2000e702ec27031b07474c783e6d5759f67e

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
