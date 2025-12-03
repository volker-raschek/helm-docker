FROM docker.io/library/alpine:3.23.0

ARG HELM_VERSION

RUN apk add bash curl git openssl && \
    curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-4 --output /tmp/install.sh

RUN if [[ -z "${HELM_VERSION+x}" ]]; then bash /tmp/install.sh; fi
RUN if [[ -n "${HELM_VERSION+x}" ]]; then bash /tmp/install.sh --version "${HELM_VERSION}"; fi

RUN rm /tmp/install.sh

ENTRYPOINT [ "/usr/local/bin/helm" ]
