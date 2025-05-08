# helm

[![Build Status](https://drone.cryptic.systems/api/badges/volker.raschek/helm-docker/status.svg)](https://drone.cryptic.systems/volker.raschek/helm-docker)

This project contains all sources to build the container image `docker.io/volkerraschek/helm`. The primary goal of this
project is to package the binary `helm` as container image to provide the functionally for CI/CD workflows. The source
code of the binary can be found in the upstream project of [helm](github.com/helm/helm).

## drone

Here is an example to lint, package and deploy a chart to chartmuseum via
`docker.io/volkerraschek/helm`.

```yaml
kind: pipeline
type: kubernetes
name: linter

platform:
  os: linux
  arch: amd64

steps:
- name: helm lint
  commands:
  - helm lint
  image: docker.io/volkerraschek/helm:latest
  resources:
    limits:
      cpu: 50
      memory: 50M

---
kind: pipeline
type: kubernetes
name: release

platform:
  os: linux

steps:
- name: release-helm-chart
  commands:
  - helm plugin install https://github.com/chartmuseum/helm-push.git
  - helm repo add myrepo https://charts.example.com/myrepo
  - helm package --version ${DRONE_TAG} .
  - helm cm-push ${DRONE_REPO_NAME}-${DRONE_TAG}.tgz myrepo
  environment:
    HELM_REPO_PASSWORD:
      from_secret: helm_repo_password
    HELM_REPO_USERNAME:
      from_secret: helm_repo_username
  image: docker.io/volkerraschek/helm:latest
  resources:
    limits:
      cpu: 50
      memory: 50M
trigger:
  event:
  - tag
```
