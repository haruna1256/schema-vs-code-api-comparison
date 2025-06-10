package main

import (
	"fmt"
	"log"
	"net"

	"google.golang.org/grpc"
	bookpb "github.com/haruna1256/schema-vs-code-api-comparison/proto/book"
	"github.com/haruna1256/schema-vs-code-api-comparison/server"
	"google.golang.org/grpc/reflection"
)

func main() {
	lis, err := net.Listen("tcp", ":50051")
	if err != nil {
		log.Fatalf("ポートの待ち受けに失敗: %v", err)
	}
	fmt.Println("gRPCサーバーを起動します... ポート:50051")

	grpcServer := grpc.NewServer()

	bookpb.RegisterBookServiceServer(grpcServer, &server.BookServiceServer{})
	reflection.Register(grpcServer)

	if err := grpcServer.Serve(lis); err != nil {
		log.Fatalf("gRPCサーバーの起動に失敗: %v", err)
	}
}
