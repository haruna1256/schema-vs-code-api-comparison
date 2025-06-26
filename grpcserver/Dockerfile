# grpcserver/Dockerfile
FROM golang:1.22

WORKDIR /app

# Goモジュールのキャッシュ用
COPY ./go.mod ./
COPY ./go.sum ./
RUN go mod download

# ソースコードを追加
COPY . .

# ビルド
RUN go build -o server .

# 実行
CMD ["./server"]
