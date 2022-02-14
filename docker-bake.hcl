variable "ALPINE_VER" { default = "UNSET" }
variable "NGINX_MAINLINE" { default = "UNSET" }
variable "NGINX_STABLE" { default = "UNSET" }
variable "CORE_COUNT" { default = "1" }
variable "REGISTRY" { default = "local" }

group "default" {
    targets = ["alpine"]
}
group "alpine" {
    targets = ["alpine-mainline", "alpine-stable"]
}


target "alpine-mainline" {
    context = "alpine/"
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
    context = "alpine/"
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
