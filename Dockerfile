FROM nvidia/cuda:11.7.1-runtime-ubuntu22.04@sha256:cda05ccf0471c3a6beb67fba08b3dd84fa20197743deed534c779b922f25b0c5

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
