# Go言語公式イメージ（Linux）をベースにする
FROM golang:1.24.2-bullseye
# 作業ディレクトリを作成
WORKDIR /app

# Go moduleファイルを先にコピーして依存取得
COPY go.mod ./
COPY go.sum ./
RUN go mod download

# 残りのコードをコピー
COPY . .

# ビルド（Linux向けになる）
RUN go build -o main .

# 実行
CMD ["./main"]