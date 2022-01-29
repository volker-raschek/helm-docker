FROM docker.io/library/alpine:3.15

ARG HELM_VERSION

COPY install.sh /install.sh
RUN VERSION=${HELM_VERSION} /install.sh
ENTRYPOINT [ "/usr/bin/helm" ]
