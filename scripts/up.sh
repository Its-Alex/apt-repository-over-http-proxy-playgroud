#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/../"

docker-compose up -d
docker-compose exec -T ubuntu-20-04 sh -c "apt update -y && apt install --no-install-recommends -y dpkg-dev"
