FROM docker.io/library/alpine:3.21.0

ARG HELM_VERSION

RUN apk add bash curl git openssl && \
    curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 --output /tmp/install.sh

RUN if [[ -z "${HELM_VERSION+x}" ]]; then bash /tmp/install.sh; fi
RUN if [[ -n "${HELM_VERSION+x}" ]]; then bash /tmp/install.sh --version "${HELM_VERSION}"; fi

RUN rm /tmp/install.sh

# Install additionally helm plugins
RUN helm plugin install https://github.com/chartmuseum/helm-push.git && \
    helm plugin install https://github.com/helm-unittest/helm-unittest.git

ENTRYPOINT [ "/usr/local/bin/helm" ]
