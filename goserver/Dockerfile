FROM golang:1.21-alpine

WORKDIR /app

# go.sum がない場合、ここは go.mod のみ
COPY go.mod ./
RUN go mod download || true  # 依存なしでも失敗しないように

# ソースをコピー
COPY . .

# ビルド
RUN go build -o main .

# 実行
CMD ["./main"]
