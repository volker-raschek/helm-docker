FROM docker.io/library/alpine:3.18.5

ARG HELM_VERSION

RUN apk add bash curl git openssl && \
    curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 --output /tmp/install.sh

RUN [[ ${HELM_VERSION} == "" ]]; bash /tmp/install.sh
RUN [[ ${HELM_VERSION} != "" ]]; bash /tmp/install.sh --version ${HELM_VERSION}

RUN rm /tmp/install.sh

# Install additionally cm-push plugin
RUN helm plugin install https://github.com/chartmuseum/helm-push.git

ENTRYPOINT [ "/usr/local/bin/helm" ]
