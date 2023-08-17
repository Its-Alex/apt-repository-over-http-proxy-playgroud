#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/../"

docker run --rm -v ./:/build --workdir /build ubuntu:20.04 dpkg-deb --build fake-debian
