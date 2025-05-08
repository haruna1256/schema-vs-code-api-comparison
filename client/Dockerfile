# Node.js LTSバージョンをベースイメージとして使用する
FROM node:lts-alpine AS builder
# 作業ディレクトリの設定
WORKDIR /app
# package.jsonとpackage-lock.jsonがあればコピーする
COPY package*.json ./
# 依存関係のインストール
RUN npm install
# すべてのファイルをコピーする
COPY . .
# プロジェクトの構築
RUN npm run build
# Dockerfile 内でのベースイメージの指定
FROM nginx:alpine
# builder stageからbuild filesをコピーする
COPY --from=builder /app/dist /usr/share/nginx/html
# ポート80を公開する
EXPOSE 80
# Nginxサーバーの起動
CMD ["nginx", "-g", "daemon off;"]