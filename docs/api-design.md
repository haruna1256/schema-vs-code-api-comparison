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
| startedAt    | string    | 読み始めた日（任意, ISO 8601）  |
| finishedAt   | string    | 読み終えた日（任意, ISO 8601）  |
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
    "status": "unread",// unread | reading | done
    "tags": ["小説","エッセイ"],
    "startedAt": "2024-04-24",
    "finishedAt": "2024-04-25",
    "createdAt": "2024-04-24"
}