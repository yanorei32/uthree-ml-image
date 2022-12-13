FROM nvidia/cuda:12.0.0-runtime-ubuntu22.04@sha256:657568c574aed1965c7bb149ec41d46fed761e429cce28f7f534dae7d22bce36

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
