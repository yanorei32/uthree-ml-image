FROM nvidia/cuda:11.7.1-runtime-ubuntu20.04@sha256:c8a5634aa83656eb653dd2175ad6f07557fd42e19e1df7285e23ffda48946374

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
