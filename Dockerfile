FROM nvidia/cuda:12.1.1-runtime-ubuntu22.04@sha256:f1c4c493ca35579af2482eecac26819bf63ef1b64a9b8e6275d0cbd73546a1e1

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
