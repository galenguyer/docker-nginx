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
    targets = ["alpine", "fancyindex-alpine", "spa-alpine", "js-challenge-alpine"]
}
group "alpine" {
    targets = ["alpine-mainline", "alpine-stable"]
}
group "fancyindex-alpine" {
    targets = ["fancyindex-alpine-mainline", "fancyindex-alpine-stable"]
}
group "spa-alpine" {
    targets = ["spa-alpine-mainline", "spa-alpine-stable"]
}
group "js-challenge-alpine" {
    targets = ["js-challenge-alpine-mainline", "js-challenge-alpine-stable"]
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

target "spa-alpine-mainline" {
    dockerfile = "Dockerfile.spa-alpine"
    args = {
        ALPINE_VER="${ALPINE_VER}"
        NGINX_VER="${NGINX_MAINLINE}"
        CORE_COUNT="${CORE_COUNT}"
    }
    tags = [
        "${REGISTRY}/nginx:spa",
        "${REGISTRY}/nginx:spa-mainline",
        "${REGISTRY}/nginx:spa-alpine",
        "${REGISTRY}/nginx:spa-alpine-mainline",
    ]
}
target "spa-alpine-stable" {
    dockerfile = "Dockerfile.spa-alpine"
    args = {
        ALPINE_VER="${ALPINE_VER}"
        NGINX_VER="${NGINX_STABLE}"
        CORE_COUNT="${CORE_COUNT}"
    }
    tags = [
        "${REGISTRY}/nginx:spa-stable",
        "${REGISTRY}/nginx:spa-alpine-stable",
    ]
}

target "js-challenge-alpine-mainline" {
    dockerfile = "Dockerfile.js-challenge-alpine"
    args = {
        ALPINE_VER="${ALPINE_VER}"
        NGINX_VER="${NGINX_MAINLINE}"
        CORE_COUNT="${CORE_COUNT}"
    }
    tags = [
        "${REGISTRY}/nginx:js-challenge",
        "${REGISTRY}/nginx:js-challenge-mainline",
        "${REGISTRY}/nginx:js-challenge-alpine",
        "${REGISTRY}/nginx:js-challenge-alpine-mainline",
    ]
}
target "js-challenge-alpine-stable" {
    dockerfile = "Dockerfile.js-challenge-alpine"
    args = {
        ALPINE_VER="${ALPINE_VER}"
        NGINX_VER="${NGINX_STABLE}"
        CORE_COUNT="${CORE_COUNT}"
    }
    tags = [
        "${REGISTRY}/nginx:js-challenge-stable",
        "${REGISTRY}/nginx:js-challenge-alpine-stable",
    ]
}
