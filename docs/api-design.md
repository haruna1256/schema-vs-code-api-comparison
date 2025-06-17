## 読書記録アプリ

### Book（書籍）一冊についての情報

| フィールド名   | 型        | 説明                            |
|--------------|-----------|---------------------------------|
| id           | string    | ユニークID（UUID形式）         |
| title        | string    | 書名                            |
| author       | string    | 著者名                          |
| memo         | string    | 感想やメモ（任意）              |
| status       | string    | 読書状況（unread / reading / done）|
| tags         | string[]  | ジャンルやタグのリスト          |
| startedAt    | string    | 読み始めた日（任意）  |
| finishedAt   | string    | 読み終えた日（任意）  |
| createdAt    | string    | 作成日時（システム管理）       |

### 読書記録アプリ API 設計概要

#### 目的
このAPIは、ユーザーが自身の読書記録を登録・管理できるようにするためのCRUD APIです。

#### エンドポイント一覧
- 登録された本の一覧取得
    -> `GET /books`

- 特定の本の詳細取得
    -> `GET /books/{id}`

- 本の新規登録
    -> `POST /books`

- 特定の本の情報を更新
    -> `PUT /books/{id}`

- 特定の本を削除
    -> `DELETE /books/{id}`

- 特定の本をステータスでの絞り込み
    -> `GET /books?status=done`

- 特定の本をタグでの絞り込み
    -> `GET /books?tags=小説`


#### 本のデータモデル
```json
{
    "id": "a13f9c6d-b849-442a-b3d4-fb05c221d2a9",
    "title": "本のタイトル",
    "author": "著者名",
    "memo": "感想やメモ（任意)",
    "status": "unread",
    "tags": ["小説","エッセイ"],
    "startedAt": "2024-04-24",
    "finishedAt": "2024-04-25",
    "createdAt": "2024-04-24"
}

```
| テーブル名     | カラム名         | 型                                 | 制約                         | 説明            |
| --------- | ------------ | --------------------------------- | -------------------------- | ------------- |
| **books** | id           | CHAR(36)                          | PRIMARY KEY                | 書籍ID（UUID固定長） |
|           | title        | VARCHAR(255)                      | NOT NULL                   | 書名            |
|           | author       | VARCHAR(100)                      | NOT NULL                   | 著者名           |
|           | memo         | TEXT                              |                            | 感想・メモ（任意）     |
|           | status       | ENUM('unread', 'reading', 'done') | NOT NULL                   | 読書状況（3種固定値）   |
|           | started\_at  | DATE                              |                            | 読み始めた日（任意）    |
|           | finished\_at | DATE                              |                            | 読み終えた日（任意）    |
|           | created\_at  | TIMESTAMP                         | DEFAULT CURRENT\_TIMESTAMP | 登録日時（自動設定）    |
| テーブル名    | カラム名 | 型           | 制約               | 説明            |
| -------- | ---- | ----------- | ---------------- | ------------- |
| **tags** | id   | CHAR(36)    | PRIMARY KEY      | タグID（UUID固定長） |
|          | name | VARCHAR(50) | UNIQUE, NOT NULL | タグ名           |

| テーブル名          | カラム名     | 型        | 制約                                                                         | 説明   |
| -------------- | -------- | -------- | -------------------------------------------------------------------------- | ---- |
| **book\_tags** | book\_id | CHAR(36) | PRIMARY KEY (book\_id, tag\_id), FOREIGN KEY → books(id) ON DELETE CASCADE | 書籍ID |
|                | tag\_id  | CHAR(36) | FOREIGN KEY → tags(id) ON DELETE CASCADE                                   | タグID |



-- 書籍テーブル
``` sql
CREATE TABLE books (
    id CHAR(36) PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(100) NOT NULL,
    memo TEXT,
    status ENUM('unread', 'reading', 'done') NOT NULL,
    started_at DATE,
    finished_at DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

-- タグテーブル
``` sql
CREATE TABLE tags (
    id CHAR(36) PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL
);
```
-- 書籍とタグの中間テーブル
``` sql
CREATE TABLE book_tags (
    book_id CHAR(36),
    tag_id CHAR(36),
    PRIMARY KEY (book_id, tag_id),
    FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE,
    FOREIGN KEY (tag_id) REFERENCES tags(id) ON DELETE CASCADE
);
```

```lua

+---------+           +-------------+           +-------+
|  books  |           |  book_tags  |           |  tags |
+---------+           +-------------+           +-------+
| id (PK) |◀──────────┤ book_id (PK,FK) ├──────▶| id (PK)|
| title   |           | tag_id  (PK,FK) │        | name  |
| author  |           +-----------------+        +-------+
| memo    |
| status  |
| started_at |
| finished_at|
| created_at |
+---------+
```