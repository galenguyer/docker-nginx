#!/usr/bin/env bash
# build, tag, and push docker images

# exit if a command fails
set -o errexit

# exit if required variables aren't set
set -o nounset

# if podman is installed, default to using it
if command -v podman 2>&1 >/dev/null; then
	echo "using podman..."
	# enable aliases for non-interactive mode
	shopt -s expand_aliases
	alias docker="podman"

# otherwise use docker
elif command -v docker 2>&1 >/dev/null; then
	echo "using docker..."

# otherwise exit
else
	echo "could not find docker or podman, exiting"
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
docker build --build-arg ALPINE_VER="$alpine" \
             --build-arg NGINX_VER="$nginx_mainline" \
             --build-arg CORE_COUNT="$core_count" \
             -t "$registry/nginx:latest" \
             -t "$registry/nginx:mainline" \
             -t "$registry/nginx:$nginx_mainline" \
             -t "$registry/nginx:alpine" \
             -t "$registry/nginx:alpine$alpine" \
             -t "$registry/nginx:alpine-mainline" \
             -t "$registry/nginx:alpine$alpine-mainline" \
             -t "$registry/nginx:alpine-$nginx_mainline" \
             -t "$registry/nginx:alpine$alpine-$nginx_mainline" \
             -f Dockerfile.alpine .

docker build --build-arg ALPINE_VER="$alpine" \
             --build-arg NGINX_VER="$nginx_stable" \
             --build-arg CORE_COUNT="$core_count" \
             -t "$registry/nginx:stable" \
             -t "$registry/nginx:$nginx_stable" \
             -t "$registry/nginx:alpine-stable" \
             -t "$registry/nginx:alpine$alpine-stable" \
             -t "$registry/nginx:alpine-$nginx_stable" \
             -t "$registry/nginx:alpine$alpine-$nginx_stable" \
             -f Dockerfile.alpine .

 # if a registry is specified, push to it
if [ "$registry" != "local" ]; then
  docker push "$registry/nginx:latest"
  docker push "$registry/nginx:mainline"
  docker push "$registry/nginx:$nginx_mainline"
  docker push "$registry/nginx:alpine"
  docker push "$registry/nginx:alpine$alpine"
  docker push "$registry/nginx:alpine-mainline"
  docker push "$registry/nginx:alpine$alpine-mainline"
  docker push "$registry/nginx:alpine-$nginx_mainline"
  docker push "$registry/nginx:alpine$alpine-$nginx_mainline"
  docker push "$registry/nginx:stable"
  docker push "$registry/nginx:$nginx_stable"
  docker push "$registry/nginx:alpine-stable"
  docker push "$registry/nginx:alpine$alpine-stable"
  docker push "$registry/nginx:alpine-$nginx_stable"
  docker push "$registry/nginx:alpine$alpine-$nginx_stable"
fi
