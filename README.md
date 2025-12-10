# helm

[![Docker Pulls](https://img.shields.io/docker/pulls/volkerraschek/helm)](https://hub.docker.com/r/volkerraschek/helm)

This project contains all sources to build the container image `git.cryptic.systems/volker.raschek/helm`. The primary
goal of this project is to package the binary `helm` as container image and provide the functionally for CI/CD workflows.
The source code of the binary can be found in the upstream project of [helm](github.com/helm/helm).

```bash
IMAGE_VERSION=4.0.2
docker run \
  --rm \
  --volume "$(pwd):$(pwd)" \
  --workdir "$(pwd)" \
    "git.cryptic.systems/volker.raschek/helm:${IMAGE_VERSION}" \
      version
```
