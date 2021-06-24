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
