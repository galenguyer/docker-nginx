# allow multiarch builds
ARG TARGETOS
ARG TARGETARCH
ARG TARGETVARIANT=""

ARG DEBIAN_VER="stable"
FROM docker.io/debian:"$DEBIAN_VER" AS builder
#RUN apk add gcc g++ git curl make linux-headers tar gzip geoip-dev gd-dev libxslt-dev pcre-dev perl-dev
RUN apt-get update -y && apt-get install -y build-essential gcc g++ cmake git gnupg curl

WORKDIR /src/pcre2/
ARG PCRE2_VER="pcre2-10.40"
RUN curl -L -O "https://github.com/PCRE2Project/pcre2/releases/download/$PCRE2_VER/$PCRE2_VER.tar.gz"
RUN tar xzf "/src/pcre2/$PCRE2_VER.tar.gz"

WORKDIR /src/nginx
ARG NGINX_VER
RUN curl -L -O "http://nginx.org/download/nginx-$NGINX_VER.tar.gz"
RUN tar xzf "/src/nginx/nginx-$NGINX_VER.tar.gz"

# configure and build nginx
WORKDIR /src/nginx/nginx-"$NGINX_VER"
RUN ./configure --prefix=/usr/share/nginx \
	--sbin-path=/usr/sbin/nginx \
	--conf-path=/etc/nginx/nginx.conf \
	--error-log-path=/var/log/nginx/error.log \
	--http-log-path=/var/log/nginx/access.log \
	--pid-path=/run/nginx.pid \
	--lock-path=/run/lock/subsys/nginx \
	--http-client-body-temp-path=/tmp/nginx/client \
	--http-proxy-temp-path=/tmp/nginx/proxy \
	--user=www-data \
	--group=www-data \
	--with-threads \
	--with-file-aio \
	--with-pcre="/src/pcre2/$PCRE2_VER" \
	--with-pcre-jit \
	--with-http_addition_module \
	--without-http_fastcgi_module \
	--without-http_uwsgi_module \
	--without-http_scgi_module \
	--without-http_gzip_module \
	--without-select_module \
	--without-poll_module \
	--without-mail_pop3_module \
	--without-mail_imap_module \
	--without-mail_smtp_module \
	--with-cc-opt="-Wl,--gc-sections -static -static-libgcc -O2 -ffunction-sections -fdata-sections -fPIE -fstack-protector-all -D_FORTIFY_SOURCE=2 -Wformat -Werror=format-security"
ARG CORE_COUNT="1"
RUN make -j"$CORE_COUNT"
RUN make install

FROM docker.io/debian:"$DEBIAN_VER"-slim

# setup nginx folders and files
RUN adduser www-data -D -H -G www-data \
	&& mkdir -p /tmp/nginx/ \
	&& mkdir -p /var/log/nginx \
	&& mkdir -p /var/www/html \
	&& ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log \
	&& mkdir -p /etc/nginx \
    && chmod g+rwx /var/run /var/log/nginx /tmp/nginx

# copy in default nginx configs
COPY conf/ etc/nginx/

# add nginx binary
COPY --from=builder /usr/sbin/nginx /usr/sbin/nginx

EXPOSE 8080
# configure CMD
CMD ["/usr/sbin/nginx","-g","daemon off;"]
