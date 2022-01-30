#!/bin/sh

BASE_URL=https://get.helm.sh

if [ -z ${VERSION+x} ]; then
  echo ${VERSION} not defined
  exit 1
fi

case `uname -m` in
  x86_64)
    ARCH=amd64
  ;;
  armv7l)
    ARCH=arm
  ;;
  aarch64)
    ARCH=arm64
  ;;
  ppc64le)
    ARCH=ppc64le
  ;;
  s390x)
    ARCH=s390x
  ;;
  *)
    echo "un-supported arch, exit ..."
    exit 1
  ;;
esac

apk add --update --no-cache wget git
wget ${BASE_URL}/helm-${VERSION}-linux-${ARCH}.tar.gz -O - | tar -xz
mv linux-${ARCH}/helm /usr/bin/helm
chmod +x /usr/bin/helm
rm -rf linux-${ARCH}