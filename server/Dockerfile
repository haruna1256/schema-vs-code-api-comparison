# Goの公式イメージを使用
FROM golang:1.24.2-bullseye

# 作業ディレクトリを設定
WORKDIR /app

# Goのモジュールファイルをコピー
COPY go.mod ./
# COPY go.sum ./

# 依存関係をダウンロード
RUN go mod tidy

# サーバーのソースコードをコピー
COPY . .

# アプリケーションをビルド
RUN go build -o /server .

# ポートを指定
EXPOSE 8080

# 実行権限を付与
RUN chmod +x /server

# サーバーを実行
CMD ["/server"]