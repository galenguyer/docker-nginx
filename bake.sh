#!/usr/bin/env bash
# build, tag, and push docker images

# exit if a command fails
set -o errexit
# exit if required variables aren't set
set -o nounset

# check for docker
if command -v docker 2>&1 >/dev/null; then
	echo "using docker..." >&2
else
	echo "could not find docker, exiting" >&2
	exit 1
fi

# if no registry is provided, tag image as "local" registry
registry="${REGISTRY:-local}"
echo "using registry $registry..." >&2

# retrieve latest alpine version
alpine="${ALPINE:-$(curl -sSL https://www.alpinelinux.org/downloads/ | grep -P 'Current Alpine Version' | grep -o -P '\d+\.\d+\.\d+')}"
echo "using alpine version $alpine..." >&2

# retreive latest nginx stable version
nginx_stable="${NGINX_STABLE:-$(curl -sSL https://nginx.org/en/download.html | grep -P '(\/download\/nginx-\d+\.\d+\.\d+\.tar\.gz)' -o | uniq | head -n2 | tail -n1 | grep -o -P '\d+\.\d+\.\d+')}"
echo "using nginx stable version $nginx_stable..." >&2

# retrieve latest nginx mainline version
nginx_mainline="${NGINX_MAINLINE:-$(curl -sSL https://nginx.org/en/download.html | grep -P '(\/download\/nginx-\d+\.\d+\.\d+\.tar\.gz)' -o | uniq | head -n1 | grep -o -P '\d+\.\d+\.\d+')}"
echo "using nginx mainline version $nginx_mainline..." >&2

# pass core count into container for build process
core_count="${CORE_COUNT:-$(nproc)}"
echo "using $core_count cores..." >&2

# create docker images
export ALPINE_VER="$alpine"
export CORE_COUNT="$core_count"
export REGISTRY="$registry"
export NGINX_MAINLINE="$nginx_mainline"
export NGINX_STABLE="$nginx_stable"
docker buildx bake \
    $(if [ "${REGISTRY}" != "local" ]; then echo "--push"; fi) \
    "$@"
