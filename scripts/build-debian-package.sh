#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/../"

# Create and clean folder used for debian-packages
mkdir -p ./nginx/packages/generic/
rm -rf ./nginx/packages/generic/*

# Create debian-package and apt repository
docker-compose exec -T ubuntu-20-04 sh -c "dpkg-deb --build fake-debian \
    && mv fake-debian.deb /workdir/nginx/packages/generic/ \
    && cd /workdir/nginx/packages/ \
    && dpkg-scanpackages generic /dev/null | gzip -9c > ./generic/Packages.gz"
