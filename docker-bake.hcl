variable "ALPINE_VER" { default = "UNSET" }
variable "NGINX_MAINLINE" { default = "UNSET" }
variable "NGINX_STABLE" { default = "UNSET" }
variable "CORE_COUNT" { default = "1" }
variable "REGISTRY" { default = "local" }

group "default" {
    targets = ["alpine"]
}
group "alpine" {
    targets = ["alpine-base", "alpine-spa"]
}
group "alpine-base" {
    targets = ["alpine-mainline", "alpine-stable"]
}
group "alpine-spa" {
    targets = ["alpine-mainline-spa", "alpine-stable-spa"]
}

target "alpine-mainline" {
    context = "alpine/base/"
    args = {
        ALPINE_VER="${ALPINE_VER}"
        NGINX_VER="${NGINX_MAINLINE}"
        CORE_COUNT="${CORE_COUNT}"
    }
    tags = [
        "${REGISTRY}/nginx:latest",
        "${REGISTRY}/nginx:alpine",
        "${REGISTRY}/nginx:alpine${ALPINE_VER}",
        "${REGISTRY}/nginx:mainline",
        "${REGISTRY}/nginx:mainline-alpine",
        "${REGISTRY}/nginx:mainline-alpine${ALPINE_VER}",
        "${REGISTRY}/nginx:${NGINX_MAINLINE}",
        "${REGISTRY}/nginx:${NGINX_MAINLINE}-alpine",
        "${REGISTRY}/nginx:${NGINX_MAINLINE}-alpine${ALPINE_VER}",
    ]
}

target "alpine-stable" {
    context = "alpine/base/"
    args = {
        ALPINE_VER="${ALPINE_VER}"
        NGINX_VER="${NGINX_STABLE}"
        CORE_COUNT="${CORE_COUNT}"
    }
    tags = [
        "${REGISTRY}/nginx:stable",
        "${REGISTRY}/nginx:stable-alpine",
        "${REGISTRY}/nginx:stable-alpine${ALPINE_VER}",
        "${REGISTRY}/nginx:${NGINX_STABLE}",
        "${REGISTRY}/nginx:${NGINX_STABLE}-alpine",
        "${REGISTRY}/nginx:${NGINX_STABLE}-alpine${ALPINE_VER}",
    ]
}

target "alpine-mainline-spa" {
    context = "alpine/spa/"
    args = {
        ALPINE_VER="${ALPINE_VER}"
        NGINX_VER="${NGINX_MAINLINE}"
        CORE_COUNT="${CORE_COUNT}"
    }
    tags = [
        "${REGISTRY}/nginx:spa",
        "${REGISTRY}/nginx:alpine-spa",
        "${REGISTRY}/nginx:alpine${ALPINE_VER}-spa",
        "${REGISTRY}/nginx:mainline-spa",
        "${REGISTRY}/nginx:mainline-alpine-spa",
        "${REGISTRY}/nginx:mainline-alpine${ALPINE_VER}-spa",
        "${REGISTRY}/nginx:${NGINX_MAINLINE}-spa",
        "${REGISTRY}/nginx:${NGINX_MAINLINE}-alpine-spa",
        "${REGISTRY}/nginx:${NGINX_MAINLINE}-alpine${ALPINE_VER}-spa",
    ]
}

target "alpine-stable-spa" {
    context = "alpine/spa/"
    args = {
        ALPINE_VER="${ALPINE_VER}"
        NGINX_VER="${NGINX_STABLE}"
        CORE_COUNT="${CORE_COUNT}"
    }
    tags = [
        "${REGISTRY}/nginx:stable-spa",
        "${REGISTRY}/nginx:stable-alpine-spa",
        "${REGISTRY}/nginx:stable-alpine${ALPINE_VER}-spa",
        "${REGISTRY}/nginx:${NGINX_STABLE}-spa",
        "${REGISTRY}/nginx:${NGINX_STABLE}-alpine-spa",
        "${REGISTRY}/nginx:${NGINX_STABLE}-alpine${ALPINE_VER}-spa",
    ]
}
