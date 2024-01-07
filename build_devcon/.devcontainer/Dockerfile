FROM devcon-node-base:1.20

COPY ./node.dot.bashrc /home/node/.bashrc
COPY ./node.dot.npmrc /home/node/.npmrc

RUN npm install -g npm@10.2.5 \
    && apt-get update && apt-get -y upgrade \
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
