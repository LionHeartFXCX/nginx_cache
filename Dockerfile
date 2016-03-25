FROM ubuntu

MAINTAINER LionHeart <LionHeart_fxc@163.com>

ENV NGINX_PATH=/nginx
ENV NGINX_VERSION=1.8.1
ENV PCRE_VERSION=8.37
ENV ZLIB_VERSION=1.2.8
ENV OPENSSL_VERSION=1.0.2g
ENV NGX_CACHE_PURGE=2.3

RUN apt-get update
RUN apt-get install -y g++
RUN apt-get install -y gcc  
RUN apt-get install -y make
RUN apt-get install -y wget

RUN mkdir -p ${NGINX_PATH}/nginx
RUN mkdir -p ${NGINX_PATH}/download

WORKDIR ${NGINX_PATH}/nginx/nginx-${NGINX_VERSION}

RUN wget "http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz" -P ${NGINX_PATH}/nginx
RUN wget "http://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz" -P ${NGINX_PATH}/download
RUN wget "ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-${PCRE_VERSION}.tar.gz" -P ${NGINX_PATH}/download
RUN wget "http://zlib.net/zlib-${ZLIB_VERSION}.tar.gz" -P ${NGINX_PATH}/download
RUN wget "http://labs.frickle.com/files/ngx_cache_purge-${NGX_CACHE_PURGE}.tar.gz" -P ${NGINX_PATH}/download
RUN tar zxvf ${NGINX_PATH}/nginx/nginx-${NGINX_VERSION}.tar.gz -C ${NGINX_PATH}/nginx
RUN tar zxvf ${NGINX_PATH}/download/openssl-${OPENSSL_VERSION}.tar.gz -C ${NGINX_PATH}/download
RUN tar zxvf ${NGINX_PATH}/download/pcre-${PCRE_VERSION}.tar.gz -C ${NGINX_PATH}/download
RUN tar zxvf ${NGINX_PATH}/download/zlib-${ZLIB_VERSION}.tar.gz -C ${NGINX_PATH}/download
RUN tar zxvf ${NGINX_PATH}/download/ngx_cache_purge-${NGX_CACHE_PURGE}.tar.gz -C ${NGINX_PATH}/download
RUN ./configure --with-pcre=${NGINX_PATH}/download/pcre-${PCRE_VERSION} \
                --with-zlib=${NGINX_PATH}/download/zlib-${ZLIB_VERSION} \
                --with-openssl=${NGINX_PATH}/download/openssl-${OPENSSL_VERSION} \
                --with-http_ssl_module \
                --add-module=${NGINX_PATH}/download/ngx_cache_purge-${NGX_CACHE_PURGE}
RUN make
RUN make install

EXPOSE 80
