#!/usr/bin/env bash
# build, tag, and push docker images

# exit if a command fails
set -o errexit

# exit if required variables aren't set
set -o nounset

# if no registry is provided, tag image as "local" registry
registry="${REGISTRY:-local}"

# retrieve latest nginx version
nginx_mainline="$(curl -sSL https://nginx.org/en/download.html | grep -P '(\/download\/nginx-\d+\.\d+\.\d+\.tar\.gz)' -o | uniq | head -n1 | grep -o -P '\d+\.\d+\.\d+')"
nginx_stable="$(curl -sSL https://nginx.org/en/download.html | grep -P '(\/download\/nginx-\d+\.\d+\.\d+\.tar\.gz)' -o | uniq | head -n2 | tail -n1 | grep -o -P '\d+\.\d+\.\d+')"

# pass core count into container for build process
core_count="$(nproc)"

echo "Using nginx mainline version $nginx_mainline, stable version $nginx_stable"

# create docker images
docker build --build-arg NGINX_VER="$nginx_mainline" \
             --build-arg CORE_COUNT="$core_count" \
             -t "$registry"/nginx:alpine \
             -t "$registry"/nginx:alpine-mainline \
             -t "$registry"/nginx:alpine-"$nginx_mainline" \
             -f Dockerfile.alpine .

docker build --build-arg NGINX_VER="$nginx_stable" \
             --build-arg CORE_COUNT="$core_count" \
             -t "$registry"/nginx:alpine-stable \
             -t "$registry"/nginx:alpine-"$nginx_stable" \
             -f Dockerfile.alpine .

 # if a registry is specified, push to it
if [ "$registry" != "local" ]; then
  docker push "$registry"/nginx:alpine
  docker push "$registry"/nginx:alpine-mainline
  docker push "$registry"/nginx:alpine-"$nginx_mainline"
  docker push "$registry"/nginx:alpine-stable
  docker push "$registry"/nginx:alpine-"$nginx_stable"
fi
