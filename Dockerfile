FROM docker.io/library/golang:1.17.6-alpine AS helm-push-plugin

RUN apk update && \
    apk upgrade && \
    apk add make git

RUN git clone https://github.com/volker-raschek/helm-push && \
    make --directory /go/helm-push build_linux && \
    cp /go/helm-push/bin/linux/$(go env GOARCH)/helm-cm-push /go/helm-push/helm-cm-push

FROM docker.io/library/alpine:3.14

ARG HELM_VERSION

COPY install.sh /install.sh
RUN VERSION=${HELM_VERSION} /install.sh

# TODO: Until the following issue is not fixed, it is not possible to install
# cm-push on other target architectures instead of amd64. Use instead the
# precompiled binary.
# https://github.com/chartmuseum/helm-push/issues/128
COPY --from=helm-push-plugin /go/helm-push/helm-cm-push /usr/bin/helm-cm-push

ENTRYPOINT [ "/usr/bin/helm" ]
