FROM docker.io/library/alpine:3.14

ARG HELM_VERSION

COPY install.sh /install.sh
RUN VERSION=${HELM_VERSION} /install.sh

# Install additionally cm-push plugin
RUN helm plugin install https://github.com/chartmuseum/helm-push.git

ENTRYPOINT [ "/usr/bin/helm" ]
