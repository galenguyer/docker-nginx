variable "ALPINE_VER" {
    default = "UNSET"
}
variable "NGINX_MAINLINE" {
    default = "UNSET"
}
variable "NGINX_STABLE" {
    default = "UNSET"
}
variable "CORE_COUNT" {
    default = "1"
}
variable "REGISTRY" {
    default = "local"
}

group "default" {
    targets = ["alpine-mainline", "alpine-stable"]
}
group "fancyindex" {
    targets = ["fancyindex-alpine-mainline", "fancyindex-alpine-stable"]
}

target "alpine-mainline" {
    dockerfile = "Dockerfile.alpine"
    args = {
        ALPINE_VER="${ALPINE_VER}"
        NGINX_VER="${NGINX_MAINLINE}"
        CORE_COUNT="${CORE_COUNT}"
    }
    tags = [
        "${REGISTRY}/nginx:latest",
        "${REGISTRY}/nginx:mainline",
        "${REGISTRY}/nginx:${NGINX_MAINLINE}",
        "${REGISTRY}/nginx:alpine",
        "${REGISTRY}/nginx:alpine${ALPINE_VER}",
        "${REGISTRY}/nginx:alpine-mainline",
        "${REGISTRY}/nginx:alpine${ALPINE_VER}-mainline",
        "${REGISTRY}/nginx:alpine-${NGINX_MAINLINE}",
        "${REGISTRY}/nginx:alpine${ALPINE_VER}-${NGINX_MAINLINE}"
    ]
}
target "alpine-stable" {
    dockerfile = "Dockerfile.alpine"
    args = {
        ALPINE_VER="${ALPINE_VER}"
        NGINX_VER="${NGINX_STABLE}"
        CORE_COUNT="${CORE_COUNT}"
    }
    tags = [
        "${REGISTRY}/nginx:stable",
        "${REGISTRY}/nginx:${NGINX_STABLE}",
        "${REGISTRY}/nginx:alpine-stable",
        "${REGISTRY}/nginx:alpine${ALPINE_VER}-stable",
        "${REGISTRY}/nginx:alpine-${NGINX_STABLE}",
        "${REGISTRY}/nginx:alpine${ALPINE_VER}-${NGINX_STABLE}"
    ]
}

target "fancyindex-alpine-mainline" {
    dockerfile = "Dockerfile.fancyindex-alpine"
    args = {
        ALPINE_VER="${ALPINE_VER}"
        NGINX_VER="${NGINX_MAINLINE}"
        CORE_COUNT="${CORE_COUNT}"
    }
    tags = [
        "${REGISTRY}/nginx:fancyindex",
        "${REGISTRY}/nginx:fancyindex-mainline",
        "${REGISTRY}/nginx:fancyindex-${NGINX_MAINLINE}",
        "${REGISTRY}/nginx:fancyindex-alpine",
        "${REGISTRY}/nginx:fancyindex-alpine${ALPINE_VER}",
        "${REGISTRY}/nginx:fancyindex-alpine-mainline",
        "${REGISTRY}/nginx:fancyindex-alpine${ALPINE_VER}-mainline",
        "${REGISTRY}/nginx:fancyindex-alpine-${NGINX_MAINLINE}",
        "${REGISTRY}/nginx:fancyindex-alpine${ALPINE_VER}-${NGINX_MAINLINE}"
    ]
}
target "fancyindex-alpine-stable" {
    dockerfile = "Dockerfile.fancyindex-alpine"
    args = {
        ALPINE_VER="${ALPINE_VER}"
        NGINX_VER="${NGINX_STABLE}"
        CORE_COUNT="${CORE_COUNT}"
    }
    tags = [
        "${REGISTRY}/nginx:fancyindex-stable",
        "${REGISTRY}/nginx:fancyindex-${NGINX_STABLE}",
        "${REGISTRY}/nginx:fancyindex-alpine-stable",
        "${REGISTRY}/nginx:fancyindex-alpine${ALPINE_VER}-stable",
        "${REGISTRY}/nginx:fancyindex-alpine-${NGINX_STABLE}",
        "${REGISTRY}/nginx:fancyindex-alpine${ALPINE_VER}-${NGINX_STABLE}"
    ]
}
