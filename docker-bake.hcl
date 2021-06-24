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
    targets = ["alpine", "fancyindex-alpine"]
}
group "alpine" {
    targets = ["alpine-mainline", "alpine-stable"]
}
group "fancyindex-alpine" {
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
        "${REGISTRY}/nginx:alpine",
        "${REGISTRY}/nginx:alpine-mainline",
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
        "${REGISTRY}/nginx:alpine-stable",
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
        "${REGISTRY}/nginx:fancyindex-alpine",
        "${REGISTRY}/nginx:fancyindex-alpine-mainline",
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
        "${REGISTRY}/nginx:fancyindex-alpine-stable",
    ]
}
