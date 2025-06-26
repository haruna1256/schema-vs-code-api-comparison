// src/pages/BookList.tsx

import { useEffect, useState } from "react";
import axios from "axios";
import "../BookList.css"

type Book = {
  id: string;
  title: string;
  author: string;
  status: "unread" | "reading" | "done";
};

export default function BookList() {
  const [books, setBooks] = useState<Book[]>([]);

  useEffect(() => {
    axios
      .get("http://localhost:8080/books")
      .then((res) => {
        console.log(res.data);  // ここでAPIレスポンスを確認
        setBooks(res.data.books || res.data);  // booksがなければレスポンス全体をセット
      })
      .catch((err) => console.error("エラー:", err));
  }, []);

  return (
  <div className="book-list">
    <h1>本の一覧</h1>
    {books.map((book) => (
      <div key={book.id} className="book-card">
        <h2 className="book-title">{book.title}</h2>
        <p className="book-author">著者: {book.author}</p>
        <p className="book-status">ステータス: {book.status}</p>
      </div>
    ))}
  </div>
);
}
