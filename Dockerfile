FROM nvidia/cuda:12.0.1-runtime-ubuntu22.04@sha256:3d735403cc96f91e5a8f30e29527d0cc39514d917aa632ea7e5a813f61f71cac

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
