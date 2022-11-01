FROM nvidia/cuda:11.7.1-runtime-ubuntu22.04@sha256:163569b7c73c13633c5a873cf466fd412ed3c3100eec3eaeb959ca4cc3058722

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
