FROM golang:1.24.2-bullseye

WORKDIR /app

# ルートの go.mod と go.sum をコピー
COPY go.mod go.sum ./

# grpcserver フォルダの中身をコピー（相対パス指定）
COPY grpcserver ./grpcserver

RUN go mod tidy

RUN go build -o server ./grpcserver/cmd

CMD ["./server"]
