#!/bin/sh
#
# docker-compose manager
#
# Author: ZiHang Gao <ocdoco@gmail.com>

replaceVersion() {
    args="$@"

    versionHooks=$(env | grep _VERSION)

    dockerfilePath=$basePath/$args
    dockerfileTpl=$dockerfilePath/Dockerfile.template
    sedPipStr="cat $dockerfileTpl"

    for hook in $versionHooks; do
        versionStr=$(echo $hook | cut -d= -f1)
        version=$(echo "${!versionStr}")
        sedPipStr=$sedPipStr' | sed s/%%'"$versionStr"'%%/'"$version"'/'
    done
    eval $sedPipStr" > $dockerfilePath/$DOCKERFILE_NAME"
}

install() {
    shift 1
    args="$@"

    replaceVersion $args
    cd $basePath/$args

    docker-compose -f docker-compose.build.yml build
}
