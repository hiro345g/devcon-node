# devcon-node

  Dev Container based on mcr.microsoft.com/devcontainers/typescript-node (docker-outside-of-docker, git, git-lfs)

　これは、mcr.microsoft.com/devcontainers/typescript-node:20-bookworm の Docker イメージをベースとし、`docker`、`git`、`node` コマンドが使えるようにした開発コンテナー（Dev Container）です。次の特長があります。

- VS Code で使える開発コンテナー（Dev Container）
- `docker`、`docker compose` といったコマンドで Docker ホストの `dockerd を利用可能
- Node.js 環境での TypeScript プログラミングが可能
- 開発コンテナー内で `git` コマンド、VS Code の Git 関連機能が利用可能
- `iproute2`、`iputils-ping`、`dnsutils` といったネットワーク管理用コマンドが利用可能

## devcon-node で解決できること

　devcon-node を使うと、Docker を利用する Node.js 環境での開発において、基本的に VS Code の開発コンテナー内で開発ができるようになります。これは、開発コンテナー内から Docker ホストの `dockerd` を利用できる `docker` コマンドが使えるからです。

　開発コンテナー内から Docker ホストの `dockerd` を利用できないと、開発時に必要な Docker コンテナーを操作するために、Docker ホスト側での作業が必要となります。そのため、Docker ホスト環境で動作する VS Code での作業と、VS Code をアタッチした開発コンテナーの作業の両方が必要となって、負担となることが多くあります。

　devcon-node を使うことで、そういった負担が軽減されます。

　また、ネットワーク管理用コマンドが利用可能なので、開発コンテナーでのネットワーク通信による問題が起きたときに調査がしやすくなっています。Node.js 環境での開発は Web アプリを対象としていることが多く、Web サーバーや DB サーバーのコンテナーとのネットワークについて確認が必要な場面があります。

　そういったときに、ネットワーク通信について確認するための環境を別途用意することなく、VS Code をアタッチした開発コンテナーでそのまま調査をすることができます。

## 使用しているもの

　devcon-node では、<https://github.com/devcontainers/images/tree/main/src/typescript-node> で公開されている mcr.microsoft.com/devcontainers/typescript-node:20-bookworm の Docker イメージをベースとしています。また、Feature に <https://github.com/devcontainers/features/> で公開されている docker-outside-of-docker、git、git-lfs を指定して Docker イメージを作成しています。

- Base Image
  - [mcr.microsoft.com/devcontainers/typescript-node:20-bookworm](https://github.com/devcontainers/images/tree/main/src/typescript-node)
- Features
  - [docker-outside-of-docker](https://github.com/devcontainers/features/tree/main/src/docker-outside-of-docker)
  - [git](https://github.com/devcontainers/features/tree/main/src/git)
  - [git-lfs](https://github.com/devcontainers/features/tree/main/src/git-lfs)

### Dev Container について

　Dev Container については、開発が <https://github.com/devcontainers> でされていますので、そちらをご覧ください。

　ここで用意している `docker-compose.yml` では、開発するアプリの Git リモートリポジトリを devcon-node コンテナーの `/home/node/workspace` （つまり、`devcon-node:/home/node/workspace`）へクローンして開発することを想定しています。

　また、`devcon-node:/home/node/workspace` は Docker ボリュームの devcon-node-node-workspace-data をマウントして使うようになっています。他にも devcon-node-vscode-server-extensions という Docker ボリュームを使うようになっています。

## 必要なもの

　devcon-node を動作をさせるには、Docker、Docker Compose、Visual Studio Code (VS Code) 、Dev Containers 拡張機能が必要です。

### Docker

- [Docker Engine](https://docs.docker.com/engine/)
- [Docker Compose](https://docs.docker.com/compose/)

　これらは [Docker Desktop](https://docs.docker.com/desktop/) をインストールしてあれば使えます。Linux では Docker Desktop をインストールしなくても Docker Engine と Docker Compose だけをインストールして使えます。例えば、Ubuntu を使っているなら [Install Docker Engine on Ubuntu](https://docs.docker.com/engine/install/ubuntu/) を参照してインストールしておいてください。

### Visual Studio Code

- [Visual Studio Code](https://code.visualstudio.com/)
- [Dev Containers 拡張機能](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

　VS Code の拡張機能である Dev Containers を VS Code へインストールしておく必要があります。

### 動作確認済みの環境

　次の環境で動作確認をしてあります。Windows や macOS でも動作するはずです。

```console
$ cat /etc/os-release 
PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy

$ docker version
Client: Docker Engine - Community
 Cloud integration: v1.0.35+desktop.5
 Version:           24.0.7
 API version:       1.43
 Go version:        go1.20.10
 Git commit:        afdd53b
 Built:             Thu Oct 26 09:07:41 2023
 OS/Arch:           linux/amd64
 Context:           default

Server: Docker Engine - Community
 Engine:
  Version:          24.0.7
  API version:      1.43 (minimum version 1.12)
  Go version:       go1.20.10
  Git commit:       311b9ff
  Built:            Thu Oct 26 09:07:41 2023
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.6.26
  GitCommit:        3dd1e886e55dd695541fdcd67420c2888645a495
 runc:
  Version:          1.1.10
  GitCommit:        v1.1.10-0-g18a0cb0
 docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0

$ docker compose version
Docker Compose version v2.23.3-desktop.2
```

## ファイルの構成

　ファイルの構成は次のようになっています。

```text
devcon-node/
├── .devcontainer/ ... devcon-node を開発コンテナー（Dev Container）として利用するときに使用
│   └── devcontainer.json
├── build_devcon/ ... devcon-node の Docker イメージをビルドするときに使用
│   ├── .devcontainer/
│   │   ├── Dockerfile
│   │   ├── devcontainer.json
│   │   ├── node.dot.bashrc
│   │   └── node.dot.npmrc
│   ├── build-base.sh ... devcon-node のベースとなる Docker イメージをビルドするためのスクリプト
│   ├── build.sh ... devcon-node の Docker イメージをビルドするためのスクリプト
│   └── devcon-node-build-dev/ ... devcon-node の Docker イメージ用設定ファイルの開発時に使用
│       ├── .devcontainer/
│       │   └── devcontainer.json
│       ├── docker-compose.yml
│       └── init.sh ... Dockerfile に記述する処理の動作確認用スクリプト
├── workspace_share/ ... Docker ホストとコンテナーとでファイルを共有するためのディレクトリー
│   └── .gitkeep
├── .gitignore
├── docker-compose.yml ... devcon-node を利用するときに使用
├── LICENSE ... ライセンス
├── README.md  ... このファイル
└── sample.env  ... .env ファイルのサンプル
```

　この後、リポジトリをクローンもしくはアーカイブファイルを展開した `devcon-node` ディレクトリーのパスを `${DEVCON_NODE_DIR}` と表現します。

## 使い方

　起動の仕方は、次のどちらかを想定しています。

- devcontainer.json を使わずに通常のコンテナーとして起動
- devcontainer.json を使った開発コンテナーとして起動

　起動したら、`devcon-node:/home/node/workspace` ディレクトリーへ開発したいアプリのリポジトリをクローンして使うことを想定しています。

　慣れないうちは通常のコンテナーとして起動して使ってください。慣れてきて、Node.js の開発専用で使うようになったら開発コンテナーとして起動して使うのが良いです。

### devcontainer.json を使わずに通常のコンテナーとして起動

　先に「ビルド」を参照して Docker イメージを作成してください。また、「環境変数」を参考にして `.env` ファイルを用意してください。

　それから、docker-compose.yml を使って devcon-node コンテナーを起動します。

```console
cd `${DEVCON_NODE_DIR}`
docker compose up -d
```

　VS Code の Docker 拡張機能画面で devcon-node コンテナーのコンテキストメニューを開きます。その中にある `Visual Studio Code をアタッチする（英語表記だと Attach Visual Studio Code）` を選択して、アタッチします。すると devcon-node コンテナーに接続した VS Code の画面が開いて使えるようになります。

### devcontainer.json を使った開発コンテナーとして起動

　先に「ビルド」を参照して Docker イメージを作成してください。また、必要なら「環境変数」を参考にして `.env` ファイルを用意してください。

　VS Code を起動してから、F1 キーを入力して VS Code のコマンドパレットを表示してます。入力欄へ「dev containers open」などと入力すると `開発コンテナー:コンテナーでフォルダを開く（英語表記だと Dev Containers: Open Folder in Container...）` が選択肢に表示されます。これをクリックすると、フォルダーを選択する画面になるので `${DEVCON_NODE_DIR}` を指定して開きます。

　これで `${DEVCON_NODE_DIR}/.devcontainer/devcontainer.json` の内容にしたがって、devcon-node コンテナーが開発コンテナーとして起動します。このとき、開発コンテナーで使用する拡張機能も追加されます。それから、devcon-node コンテナーに接続した VS Code の画面が表示されます。

　devcon-node コンテナーに接続した VS Code の画面での作業は devcon-node コンテナーのリソースを使うことになります。そのため、この画面でファイルを編集すると、devcon-node コンテナー内のファイルを編集するということになります。

　devcon-node コンテナーでは Docker ホストのファイルを間違えて操作しないように、`${DEVCON_NODE_DIR}` は見えないようにしてあります。devcon-node コンテナーと Docker ホストとの間でファイルをやりとりしたいときは、devcon-node コンテナーの `/share` ディレクトリー（`devcon-node:/share`）を使います。

　`devcon-node:/share` は Docker ホスト側の `${DEVCON_NODE_DIR}/workspace_share` にバインドマウントしてあるので、ここにあるファイルは、Docker ホスト側でも使えます。

　`devcon-node:/share` を経由しなくても、`docker compose -p devcon-node cp <転送するファイル> <転送先のファイル>` のコマンドを使ってファイル転送をすることもできます。

### コンテナーの停止、削除の仕方

　VS Code の Docker 拡張機能の画面で、CONTAINERS の欄に表示されている devcon-node のコンテキストメニューから `Compose Stop` でコンテナー停止、`Compose Down` でコンテナー削除ができます。

## ビルド

　devcon-node を使うには、最初にビルドが必要です。

　Dev Container 環境を起動する度に自動でビルドを実行する必要はないので、ビルド作業を別にしてあります。すでにビルド済みのものを Docker Hub で公開してあるので、それを使うのが簡単です。自分でビルドをする場合は次の2つの方法があります。

- VS Code を使う方法
- build-base.sh と build.sh を使う方法

　合計3つの方法があるので順番に説明します。

### Docker Hub で公開されているビルド済みのものを使う方法

　Docker Hub で公開されているビルド済みのものをダウンロードしてタグをつけます。

```console
docker pull hiro345g/devcon-node:1.20
docker image tag hiro345g/devcon-node:1.20 devcon-node:1.20
```

### VS Code を使う方法

　VS Code を起動してから、F1 キーを入力して VS Code のコマンドパレットを表示してます。入力欄へ「dev containers open」などと入力すると `開発コンテナー:コンテナーでフォルダを開く（英語表記だと Dev Containers: Open Folder in Container...）` が選択肢に表示されます。これをクリックすると、フォルダーを選択する画面になるので `${DEVCON_NODE_DIR}/build_devcon` を指定して開きます。

　`vsc-build_devcon-` で始まる Docker イメージが作成されてコンテナーが起動します。このコンテナーに対応する `vsc-build_devcon-` で始まる Docker イメージがあるので、それに `devcon-node:1.20` のタグをつけます。

　例えば、次の例だと vsc-build_devcon-b3ed032a709b975173b2f2fcf5212c79-uid といったイメージが作成されたので、それに対して `devcon-node:1.20` のタグをつけています。

```console
$ docker container ls | grep vsc | grep build_devcon
351cab45fe6c   vsc-build_devcon-b3ed032a709b975173b2f2fcf5212c79-uid   （略）
$ docker tag vsc-build_devcon-b3ed032a709b975173b2f2fcf5212c79-uid devcon-node:1.20
```

### build-base.sh と build.sh を使う方法

　build-base.sh と build.sh を使う場合は、まず build-base.sh を実行して devcon-node のベースイメージを用意してから、build.sh を実行します。

```console
sh /home/node/build_devcon/build-base.sh 
sh /home/node/build_devcon/build.sh 
```

　これらのスクリプトを実行するには、`sh` コマンドが実行できる Bash 環境と `npm` コマンドが実行できる Node.js 環境が必要です。

　ここでは、`npm` コマンドが実行できる Node.js 環境として、`devcon-node-build-dev` の開発コンテナーを用意してあるので、これを使います。

　VS Code を起動してから、F1 キーを入力して VS Code のコマンドパレットを表示してます。入力欄へ「dev containers open」などと入力すると `開発コンテナー:コンテナーでフォルダを開く（英語表記だと Dev Containers: Open Folder in Container...）` が選択肢に表示されます。これをクリックすると、フォルダーを選択する画面になるので `${DEVCON_NODE_DIR}/build_devcon/devcon-node-build-dev` を指定して開きます。すると、devcon-node-build-dev コンテナーに接続した VS Code の画面が表示されます。

　次に、Docker ホスト側のターミナルで、`${REPO_DIR}`（`devcon-node` をクローンしたディレクトリー）をカレントディレクトリーとして、次のコマンドで、`build_devcon` を devcon-node-build-dev コンテナーの `/home/node/` へコピーします。

```console
docker compose -p devcon-node-build-dev \
  cp build_devcon devcon-node-build-dev:/home/node/
```

　次に devcon-node-build-dev コンテナーに接続した VS Code の画面でターミナルを開き、ビルドスクリプトを実行します。

```console
node ➜ ~ $ sh /home/node/build_devcon/build-base.sh 
（略）
{"outcome":"success","imageName":["devcon-node-base:1.20"]}
npm notice 
（略）
```

　実行結果で、`{"outcome":"success","imageName":["devcon-node-base:1.20"]}` のように出力されたら成功です。`npm notic` 以降の表示は無視して大丈夫です。

　引き続き devcon-node-build-dev コンテナーに接続した VS Code の画面のターミナルを使い、ビルドスクリプト `build.sh` を実行します。

```console
node ➜ ~ $ sh /home/node/build_devcon/build.sh 
（略）
{"outcome":"success","imageName":["devcon-node:1.20"]}
```

　実行結果で、`{"outcome":"success","imageName":["devcon-node:1.20"]}` と出力されたら成功です。こちらも、`npm notic` 以降の表示は無視して大丈夫です。

## 環境変数

　コンテナーと Docker ホストとでファイルを手軽に参照したり転送したりできるように、`devcon-node:/share` をバインドマウントするようにしています。

　Docker ホスト側で使用するディレクトリーを `SHARE_DIR` で指定します。Docker ホスト側に存在するものを指定してください。ここでは、あらかじめ `workspace_share` ディレクトリーを用意してあり、それを使っています。

　なお、これを変更することができるように、環境変数 `SHARE_DIR` を用意してあります。次の例では `${DEVCON_NODE_DIR}/share` ディレクトリーを作成して、それを使うようにしています。

```sh
cd ${DEVCON_NODE_DIR}
mkdir share
echo 'SHARE_DIR=./share' > .env
```

　また、`sample.env` も参考にしてください。`sample.env` のコメントにあるように、Docker ホストが Linux なら `devcon-node` をカレントディレクトリーにして下記のようにして .env の用意をすることができます。

```sh
echo "SHARE_DIR=$(pwd)/workspace_share" > .env
```
