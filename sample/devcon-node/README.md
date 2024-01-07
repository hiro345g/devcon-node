# sample/devcon-node

　これは、Docker Hub に用意されている devcon-node の Docker イメージ hiro345g/devcon-node を手軽に試すためのサンプルです。

  hiro345g/devcon-node は、mcr.microsoft.com/devcontainers/typescript-node:20-bookworm の Docker イメージをベースとし、`docker`、`git`、`node` コマンドが使えるようにした開発コンテナー（Dev Container）です。次の特長があります。

- VS Code で使える開発コンテナー（Dev Container）
- `docker`、`docker compose` といったコマンドで Docker ホストの `dockerd を利用可能
- Node.js 環境での TypeScript プログラミングが可能
- 開発コンテナー内で `git` コマンド、VS Code の Git 関連機能が利用可能
- `iproute2`、`iputils-ping`、`dnsutils` といったネットワーク管理用コマンドが利用可能

　これ以降、この `README.md` ファイルがある `devcon-node` ディレクトリーのパスを `${DEVCON_NODE_DIR}` と表現します。

## devcon-node で解決できること

　devcon-node を使うと、Docker を利用する Node.js 環境での開発において、基本的に VS Code の開発コンテナー内で開発ができるようになります。これは、開発コンテナー内から Docker ホストの `dockerd` を利用できる `docker` コマンドが使えるからです。

　開発コンテナー内から Docker ホストの `dockerd` を利用できないと、開発時に必要な Docker コンテナーを操作するために、Docker ホスト側での作業が必要となります。そのため、Docker ホスト環境で動作する VS Code での作業と、VS Code をアタッチした開発コンテナーの作業の両方が必要となって、負担となることが多くあります。

　devcon-node を使うことで、そういった負担が軽減されます。

　また、ネットワーク管理用コマンドが利用可能なので、開発コンテナーでのネットワーク通信による問題が起きたときに調査がしやすくなっています。Node.js 環境での開発は Web アプリを対象としていることが多く、Web サーバーや DB サーバーのコンテナーとのネットワークについて確認が必要な場面があります。

　そういったときに、ネットワーク通信について確認するための環境を別途用意することなく、VS Code をアタッチした開発コンテナーでそのまま調査をすることができます。

## 開発コンテナーとして起動

　それでは、devcon-node を開発コンテナーとして起動して使ってみましょう。

　まずは普通に VS Code を起動します。それから、F1 キーを入力して VS Code のコマンドパレットを表示してます。入力欄へ「dev containers open」などと入力すると `開発コンテナー:コンテナーでフォルダを開く（英語表記だと Dev Containers: Open Folder in Container...）` が選択肢に表示されます。これをクリックすると、フォルダーを選択する画面になるので `${DEVCON_NODE_DIR}` を指定して開きます。

　これで `${DEVCON_NODE_DIR}/.devcontainer/devcontainer.json` の内容にしたがって、devcon-node コンテナーが開発コンテナーとして起動します。このとき、開発コンテナーで使用する拡張機能も追加されます。それから、devcon-node コンテナーに接続した VS Code の画面が表示されます。

## 開発コンテナーの `/workspace` について

　devcon-node コンテナーに接続した VS Code の画面では、`/workspace` ディレクトリー（以降、`devcon-node:/workspace` のように `コンテナー名:パス` で表記します。）が開かれているはずです。これは、Docker ホストの `${DEVCON_NODE_DIR}` フォルダを Docker ボリュームのバインドマウント機能でマウントしたものなので、この中でファイルを編集すると、Docker ホストの `${DEVCON_NODE_DIR}` フォルダにあるファイルに反映されます。逆に Docker ホストの `${DEVCON_NODE_DIR}` フォルダにあるファイルを編集すると、`devcon-node:/workspace` にあるファイルに反映されます。

　このことからわかるように、Docker ホストの `${DEVCON_NODE_DIR}` フォルダへ開発時に使用するファイルを置いて、開発コンテナー devcon-node で編集作業や動作確認をすると、開発作業が捗ります。

　なお、devcon-node コンテナーに接続した VS Code の画面での作業は基本的に devcon-node コンテナーのリソースを使うことになります。そのため、この画面で `/home/node/workspace/sample.txt` ファイルを編集すると、devcon-node コンテナー内の `/home/nodw/workspace/sample.txt` ファイルを編集するということになります。ですから、`devcon-node:/workspace` は、`docker-compose.yml` の指定により特別なパスになっている点に注意してください。

## Docker ホストへのファイル転送

　devcon-node コンテナー内で作成したり編集したファイルを Docker ホストの `${DEVCON_NODE_DIR}` フォルダ以外へ転送したい時があります。その場合は、`docker compose cp` コマンドを使います。

```console
docker compose -p devcon-node cp <転送するファイル> <転送先のファイル>
```

　例えば、`devcon-node:/home/node/workspace/sample.txt` を Docker ホストの `/home/user001/sample.txt` へ転送する場合は、Docker ホストのターミナルで次のようにします。

```console
docker compose -p devcon-node \
    cp devcon-node:/home/node/workspace/sample.txt /home/user001/sample.txt
```

## `${localWorkspaceFolder}`

　ここで使っている開発コンテナーの設定ファイル `${DEVCON_NODE_DIR}/.devcontainer/devcontainer.json` では、開発コンテナー内で使える環境変数として `DOCKER_HOST_WORKSPACE_FOLDER` を指定しています。

　この環境変数には、`${localWorkspaceFolder}` という特別な変数を値として設定しています。この値は、Docker ホストの `${DEVCON_NODE_DIR}` のパスになります。

　開発コンテナー側で `docker` コマンドを使っていると、Docker ホストの `${DEVCON_NODE_DIR}` のパスを指定したい場面が出てくることがあるので、用意しています。

　良く使われる設定なので、サンプルでも指定しました。
