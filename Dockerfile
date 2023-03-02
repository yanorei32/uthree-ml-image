FROM nvidia/cuda:12.0.1-runtime-ubuntu22.04@sha256:81d1a19e09cccafb31511f8b654baac30399d9d08ea2966ba4986dcab0be5d52

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
