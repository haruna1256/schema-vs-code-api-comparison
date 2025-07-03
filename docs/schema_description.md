# データベース設計書

# 概要
読書管理アプリのデータベーススキーマを記述したものです
GOでの実装を前提に、必要なテーブル構成、リレーション、型情報をまとめています


##  テーブル定義
---
### books
| カラム名 | 型 | 制約 | 説明 |
|--------|----|-----|-----|
| id             | CHAR(36)                        | PRIMARY KEY                     | UUID（書籍ID）     |
| title          | VARCHAR(255)                    | NOT NULL                        | 書名              |
| author         | VARCHAR(100)                    | NOT NULL                        | 著者名             |
| memo           | TEXT                            |                                  | 感想・メモ（任意）  |
| status         | ENUM('unread','reading','done') | NOT NULL                        | 読書状況          |
| started_at     | DATE                            |                                  | 読み始めた日（任意） |
| finished_at    | DATE                            |                                  | 読み終えた日（任意） |
| created_at     | TIMESTAMP                       | DEFAULT CURRENT_TIMESTAMP       | 作成日時          |
---
### tags
| カラム名 | 型         | 制約                     | 説明     |
|----------|------------|--------------------------|----------|
| id       | CHAR(36)   | PRIMARY KEY              | タグID    |
| name     | VARCHAR(50)| UNIQUE, NOT NULL         | タグ名    |

---
### book_tags(中間テーブル)
| カラム名 | 型       | 制約                                                                 | 説明     |
|----------|----------|----------------------------------------------------------------------|----------|
| book_id  | CHAR(36) | PRIMARY KEY, FK → books(id) ON DELETE CASCADE                       | 書籍ID    |
| tag_id   | CHAR(36) | PRIMARY KEY, FK → tags(id) ON DELETE CASCADE  
ー--

## リレーション

- `books` と `tags` は多対多関係。`book_tags` によって管理。
- `book_tags.book_id` は `books.id` に外部キー制約付きで結びつく（削除時に連鎖削除）。
- `book_tags.tag_id` は `tags.id` に外部キー制約付きで結びつく（削除時に連鎖削除）。
---
