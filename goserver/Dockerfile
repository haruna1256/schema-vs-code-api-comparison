# Stage 1: Build the Go application
FROM golang:1.24-alpine AS builder

WORKDIR /app

# Goモジュールに外部依存がないため、go.mod/go.sum のコピーとgo mod downloadは不要
# COPY go.mod .
# COPY go.sum .
# RUN go mod download

# Goアプリケーションのソースコードを全てコピー
COPY . .

# GoアプリケーションをLinux用にビルドします。
# CGO_ENABLED=0 はCGOを無効にし、バイナリを静的リンクにしてDockerでの移植性を高めます。
# GOOS=linux と GOARCH=amd64 は明示的にターゲットOSとアーキテクチャを設定します。
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o main .

# Stage 2: Create the final, minimal image
FROM alpine:latest

WORKDIR /app

# ビルダー（builder）ステージからコンパイル済みのバイナリをコピー
COPY --from=builder /app/main .

# Goアプリケーションがリッスンするポート（例: 8080）を公開
EXPOSE 8080

# Goアプリケーションを実行するコマンド
CMD ["./main"]