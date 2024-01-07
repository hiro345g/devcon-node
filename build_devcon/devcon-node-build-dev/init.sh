#!/bin/sh

if [ -e /share/node.dot.bashrc ]; then
    cp /share/node.dot.bashrc /home/node/.bashrc
fi
if [ ! -e /home/node/.npmrc ]; then
    if [ -e /share/node.dot.npmrc ]; then
        cp /share/node.dot.npmrc /home/node/.npmrc
    fi
fi

apt-get update && apt-get -y upgrade \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install bash-completion \
        iproute2 iputils-ping dnsutils \
    && sed -i -E 's/# (ja_JP.UTF-8)/\1/' /etc/locale.gen \
    && locale-gen \
    && rm /etc/localtime \
    && ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
    && mkdir -p /home/node/workspace /home/node/.vscode-server/extensions \
    && cp -r /usr/local/share/npm-global/ /home/node/workspace/.npm-global \
    && chown -R node:node \
            /home/node/.bashrc /home/node/.npmrc \
            /home/node/workspace /home/node/.vscode-server \
            /home/node/workspace/.npm-global
