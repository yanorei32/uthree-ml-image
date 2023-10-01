FROM nvidia/cuda:12.1.1-runtime-ubuntu22.04@sha256:0c9c104250dfba7db35c97e1e837aad4a90ac2b2b8bb17782640a6831cbfc65d

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
