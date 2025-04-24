# Node.jsの公式イメージをベースに
FROM node:18

# 作業ディレクトリを設定
WORKDIR /app

# パッケージのインストールに必要なファイルをコピー
COPY package.json ./
COPY package-lock.json ./

# 依存関係をインストール
RUN npm install

# アプリケーションのソースコードをコピー
COPY . .

# ビルド
RUN npm run build

# サーバー用の軽量なイメージを使用
FROM nginx:alpine

# コンテナが公開するポートを指定
EXPOSE 3000

# アプリケーションを実行
CMD ["npm", "start"]
