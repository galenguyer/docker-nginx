#!/usr/bin/env bash
# build, tag, and push docker images

# exit if a command fails
set -o errexit

# exit if required variables aren't set
set -o nounset

# check for docker
if command -v docker 2>&1 >/dev/null; then
	echo "using docker..."
else
	echo "could not find docker, exiting"
	exit 1
fi

# if no registry is provided, tag image as "local" registry
registry="${REGISTRY:-local}"
echo "using registry $registry..."

# retrieve latest alpine version
alpine_lat="$(curl -sSL https://www.alpinelinux.org/downloads/ | grep -P 'Current Alpine Version' | grep -o -P '\d+\.\d+\.\d+')"
alpine="${ALPINE:-$alpine_lat}"
echo "using alpine version $alpine..."

# retreive latest nginx stable version
nginx_stable="$(curl -sSL https://nginx.org/en/download.html | grep -P '(\/download\/nginx-\d+\.\d+\.\d+\.tar\.gz)' -o | uniq | head -n2 | tail -n1 | grep -o -P '\d+\.\d+\.\d+')"
echo "using nginx stable version $nginx_stable..."

# retrieve latest nginx mainline version
nginx_mainline="$(curl -sSL https://nginx.org/en/download.html | grep -P '(\/download\/nginx-\d+\.\d+\.\d+\.tar\.gz)' -o | uniq | head -n1 | grep -o -P '\d+\.\d+\.\d+')"
echo "using nginx mainline version $nginx_mainline..."

# pass core count into container for build process
core_count="$(nproc)"
echo "using $core_count cores..."

# create docker images
export ALPINE_VER="$alpine"
export CORE_COUNT="$core_count"
export REGISTRY="$registry"
export NGINX_MAINLINE="$nginx_mainline"
export NGINX_STABLE="$nginx_stable"
docker buildx bake "$@"

 # if a registry is specified, push to it
if [ "$registry" != "local" ]; then
  docker push "$registry/nginx:latest"
  docker push "$registry/nginx:mainline"
  docker push "$registry/nginx:alpine"
  docker push "$registry/nginx:alpine-mainline"
  docker push "$registry/nginx:stable"
  docker push "$registry/nginx:alpine-stable"
  docker push "$registry/nginx:fancyindex"
  docker push "$registry/nginx:fancyindex-mainline"
  docker push "$registry/nginx:fancyindex-alpine"
  docker push "$registry/nginx:fancyindex-alpine-mainline"
  docker push "$registry/nginx:fancyindex-stable"
  docker push "$registry/nginx:fancyindex-alpine-stable"
fi
