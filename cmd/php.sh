#!/bin/sh
#
# PHP
#
# Author: ZiHang Gao <ocdoco@gmail.com>

php() {
    shift 1
    args=()
    for arg in "$@"; do
        args=("${args[@]}" "'$arg'")
    done

    phpCommand="php ${args[@]}"

    localPhpConfg=$basePath/data/etc/php/php.local.ini
    if [ ! -f $localPhpConfg ]; then
        touch $localPhpConfg
    fi

    tty=
    tty -s && tty=--tty

    eval "docker run $tty --rm \
        -v $currentPath:$currentPath \
        -v $basePath/data/etc/alpine/localtime:/etc/localtime \
        -v $basePath/data/etc/php/php.ini:/usr/local/etc/php/php.ini \
        -v $basePath/data/etc/php/php.local.ini:/usr/local/etc/php/conf.d/php.local.ini \
        -w $currentPath ${DCM_IMAGE_PREFIX}/php:${PHP_VERSION} \
        $phpCommand"
}