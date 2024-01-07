#! /bin/sh
IMAGE_NAME=devcon-node-base:1.20
BUILD_DEVCON_DIR=$(cd $(dirname $0);pwd)
PATH=${PATH}:${NPM_CONFIG_PREFIX}/bin

cd ${BUILD_DEVCON_DIR}
npm exec --package=@devcontainers/cli -- \
    devcontainer build --workspace-folder ./devcon-node-build-dev --image-name ${IMAGE_NAME} --no-cache