# docker-nginx
automatic builds of nginx with multiple architectures and rootless support

## tags
- alpine-mainline: latest, alpine, alpine3.16.2, mainline, mainline-alpine, mainline-alpine3.16.2, 1.23.1, 1.23.1-alpine, 1.23.1-alpine3.16.2
- alpine-mainline-autoindex: autoindex, alpine-autoindex, alpine3.16.2-autoindex, mainline-autoindex, mainline-alpine-autoindex, mainline-alpine3.16.2-autoindex, 1.23.1-autoindex, 1.23.1-alpine-autoindex, 1.23.1-alpine3.16.2-autoindex
- alpine-mainline-spa: spa, alpine-spa, alpine3.16.2-spa, mainline-spa, mainline-alpine-spa, mainline-alpine3.16.2-spa, 1.23.1-spa, 1.23.1-alpine-spa, 1.23.1-alpine3.16.2-spa
- alpine-stable: stable, stable-alpine, stable-alpine3.16.2, 1.22.0, 1.22.0-alpine, 1.22.0-alpine3.16.2
- alpine-stable-autoindex: stable-autoindex, stable-alpine-autoindex, stable-alpine3.16.2-autoindex, 1.22.0-autoindex, 1.22.0-alpine-autoindex, 1.22.0-alpine3.16.2-autoindex
- alpine-stable-spa: stable-spa, stable-alpine-spa, stable-alpine3.16.2-spa, 1.22.0-spa, 1.22.0-alpine-spa, 1.22.0-alpine3.16.2-spa

## build options
ALPINE_VER: 3.16.2
NGINX_MAINLINE: 1.23.1
NGINX_STABLE: 1.22.0
PCRE2_VER: pcre2-10.40
