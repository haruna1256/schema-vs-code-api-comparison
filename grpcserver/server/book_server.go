package server

import (
	"context"
	"github.com/haruna1256/schema-vs-code-api-comparison/grpcserver/proto/book"
)

type BookServiceServer struct {
	book.UnimplementedBookServiceServer
}

func (s *BookServiceServer) GetBook(ctx context.Context, req *book.GetBookRequest) (*book.GetBookResponse, error) {
	return &book.GetBookResponse{
		Book: &book.Book{
			Id:     req.Id,
			Title:  "仮の本のタイトル",
			Author: "仮の著者",
			Status: "done",
		},
	}, nil
}

func (s *BookServiceServer) ListBooks(ctx context.Context, req *book.ListBooksRequest) (*book.ListBooksResponse, error) {
	return &book.ListBooksResponse{
		Books: []*book.Book{
			{
				Id:     "1",
				Title:  "サンプル本",
				Author: "だれかさん",
				Status: "reading",
			},
		},
	}, nil
}
