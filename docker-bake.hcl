variable "ALPINE_VER" { default = "UNSET" }
variable "DEBIAN_VER" { default = "UNSET" }
variable "NGINX_MAINLINE" { default = "UNSET" }
variable "NGINX_STABLE" { default = "UNSET" }
variable "PCRE2_VER" { default = "UNSET" }
variable "CORE_COUNT" { default = "1" }
variable "REGISTRY" { default = "local" }

group "default" {
    targets = ["alpine", "debian"]
}
group "alpine" {
    targets = ["alpine-base", "alpine-spa", "alpine-autoindex"]
}
group "alpine-base" {
    targets = ["alpine-mainline", "alpine-stable"]
}
group "alpine-spa" {
    targets = ["alpine-mainline-spa", "alpine-stable-spa"]
}
group "alpine-autoindex" {
    targets = ["alpine-mainline-autoindex", "alpine-stable-autoindex"]
}

group "debian" {
    targets = ["debian-base"]
}
group "debian-base" {
    targets = ["debian-mainline", "debian-stable"]
}


target "alpine-mainline" {
    context = "alpine/base/"
    args = {
        ALPINE_VER="${ALPINE_VER}"
        NGINX_VER="${NGINX_MAINLINE}"
	PCRE2_VER="${PCRE2_VER}"
        CORE_COUNT="${CORE_COUNT}"
    }
    platforms = ["linux/amd64", "linux/386", "linux/arm/v6", "linux/arm/v7", "linux/arm64"]
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
	PCRE2_VER="${PCRE2_VER}"
        CORE_COUNT="${CORE_COUNT}"
    }
    platforms = ["linux/amd64", "linux/386", "linux/arm/v6", "linux/arm/v7", "linux/arm64"]
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
	PCRE2_VER="${PCRE2_VER}"
        CORE_COUNT="${CORE_COUNT}"
    }
    platforms = ["linux/amd64", "linux/386", "linux/arm/v6", "linux/arm/v7", "linux/arm64"]
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
	PCRE2_VER="${PCRE2_VER}"
        CORE_COUNT="${CORE_COUNT}"
    }
    platforms = ["linux/amd64", "linux/386", "linux/arm/v6", "linux/arm/v7", "linux/arm64"]
    tags = [
        "${REGISTRY}/nginx:stable-spa",
        "${REGISTRY}/nginx:stable-alpine-spa",
        "${REGISTRY}/nginx:stable-alpine${ALPINE_VER}-spa",
        "${REGISTRY}/nginx:${NGINX_STABLE}-spa",
        "${REGISTRY}/nginx:${NGINX_STABLE}-alpine-spa",
        "${REGISTRY}/nginx:${NGINX_STABLE}-alpine${ALPINE_VER}-spa",
    ]
}

target "alpine-mainline-autoindex" {
    context = "alpine/autoindex/"
    args = {
        ALPINE_VER="${ALPINE_VER}"
        NGINX_VER="${NGINX_MAINLINE}"
	PCRE2_VER="${PCRE2_VER}"
        CORE_COUNT="${CORE_COUNT}"
    }
    platforms = ["linux/amd64", "linux/386", "linux/arm/v6", "linux/arm/v7", "linux/arm64"]
    tags = [
        "${REGISTRY}/nginx:autoindex",
        "${REGISTRY}/nginx:alpine-autoindex",
        "${REGISTRY}/nginx:alpine${ALPINE_VER}-autoindex",
        "${REGISTRY}/nginx:mainline-autoindex",
        "${REGISTRY}/nginx:mainline-alpine-autoindex",
        "${REGISTRY}/nginx:mainline-alpine${ALPINE_VER}-autoindex",
        "${REGISTRY}/nginx:${NGINX_MAINLINE}-autoindex",
        "${REGISTRY}/nginx:${NGINX_MAINLINE}-alpine-autoindex",
        "${REGISTRY}/nginx:${NGINX_MAINLINE}-alpine${ALPINE_VER}-autoindex",
    ]
}

target "alpine-stable-autoindex" {
    context = "alpine/autoindex/"
    args = {
        ALPINE_VER="${ALPINE_VER}"
        NGINX_VER="${NGINX_STABLE}"
	PCRE2_VER="${PCRE2_VER}"
        CORE_COUNT="${CORE_COUNT}"
    }
    platforms = ["linux/amd64", "linux/386", "linux/arm/v6", "linux/arm/v7", "linux/arm64"]
    tags = [
        "${REGISTRY}/nginx:stable-autoindex",
        "${REGISTRY}/nginx:stable-alpine-autoindex",
        "${REGISTRY}/nginx:stable-alpine${ALPINE_VER}-autoindex",
        "${REGISTRY}/nginx:${NGINX_STABLE}-autoindex",
        "${REGISTRY}/nginx:${NGINX_STABLE}-alpine-autoindex",
        "${REGISTRY}/nginx:${NGINX_STABLE}-alpine${ALPINE_VER}-autoindex",
    ]
}


target "debian-mainline" {
    context = "debian/base/"
    args = {
        DEBIAN_VER="${DEBIAN_VER}"
        NGINX_VER="${NGINX_MAINLINE}"
	PCRE2_VER="${PCRE2_VER}"
        CORE_COUNT="${CORE_COUNT}"
    }
    platforms = ["linux/amd64", "linux/386", "linux/arm/v6", "linux/arm/v7", "linux/arm64"]
    tags = [
        "${REGISTRY}/nginx:debian",
        "${REGISTRY}/nginx:debian${DEBIAN_VER}",
        "${REGISTRY}/nginx:mainline-debian",
        "${REGISTRY}/nginx:mainline-debian${DEBIAN_VER}",
        "${REGISTRY}/nginx:${NGINX_MAINLINE}-debian",
        "${REGISTRY}/nginx:${NGINX_MAINLINE}-debian${DEBIAN_VER}",
    ]
}

target "debian-stable" {
    context = "debian/base/"
    args = {
        DEBIAN_VER="${DEBIAN_VER}"
        NGINX_VER="${NGINX_STABLE}"
	PCRE2_VER="${PCRE2_VER}"
        CORE_COUNT="${CORE_COUNT}"
    }
    platforms = ["linux/amd64", "linux/386", "linux/arm/v6", "linux/arm/v7", "linux/arm64"]
    tags = [
        "${REGISTRY}/nginx:stable-debian",
        "${REGISTRY}/nginx:stable-debian${DEBIAN_VER}",
        "${REGISTRY}/nginx:${NGINX_STABLE}-debian",
        "${REGISTRY}/nginx:${NGINX_STABLE}-debian${DEBIAN_VER}",
    ]
}
