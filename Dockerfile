FROM nvidia/cuda:12.0.0-runtime-ubuntu22.04@sha256:68759aedc8741c65fd34e641d1c203081d97304434bea1ce28fd8a38daaf928b

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
