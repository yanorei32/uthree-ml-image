FROM nvidia/cuda:11.8.0-runtime-ubuntu22.04@sha256:33cfe13a45ea95818d82ce1ad82d718b78dc8627e1d895c1092fd704f750045a

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
