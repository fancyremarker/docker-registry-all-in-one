#!/bin/bash
set -o errexit
set -o nounset

export GOPATH=/go

apt-get update
apt-get -y install golang librados2
rm -rf /var/lib/apt/lists/*

GOPKG="github.com/docker/distribution"
GIT_TAG="v2.6.1"

go get "$GOPKG"

cd "/go/src/${GOPKG}"
git checkout "$GIT_TAG"
make clean binaries

mkdir -p /etc/docker/registry

mv "/go/src/${GOPKG}/bin/"* /usr/local/bin/
