# 🧪 開発・検証ログ：スキーマ駆動開発 vs コードファースト

このファイルでは、各手法の開発プロセスでの気づき・所要時間・問題点などを記録する。

---

## ⏱ ログ記録フォーマット

### [日付] 実施内容
#### ✅ 手法：
- OpenAPI / gRPC / コードファースト（該当部分だけ残す）

#### 🧭 実施内容：
- 実装・設計・修正など具体的な作業内容

#### ⌛ 所要時間：
- 実装にかかった時間（例：90分）

#### 💡 気づき・課題・感想：
- 手順の楽さ／難しさ
- ドキュメントの扱いやすさ
- 思ったより時間がかかった・早かった点
- ツールの使い勝手
- 保守しやすさ など自由に

---

## 📝 ログ一覧

### 2025-04-23 使用する構成ファイル、テンプレートの作成

#### ✅ 手法：
- 

#### 🧭 実施内容：
- 必要なファイルの作成

#### ⌛ 所要時間：
- 約1時間

#### 💡 気づき・課題・感想：
- GPTにフォーマットを作ってもらったり、自分の作成した案へのフィードバックをもらう重要性を感じた

---

### 2025-05-01 dockerでの環境構築

#### ✅ 手法：
- docker

#### 🧭 実施内容：
- 環境構築

#### ⌛ 所要時間：
- 

#### 💡 気づき・課題・感想：
- 
---

### 2025-05-08 openapi

#### ✅ 手法：
- openapi

#### 🧭 実施内容：
- モックサーバーの環境構築

#### ⌛ 所要時間：
- 1h

#### 💡 気づき・課題・感想：
- OpenAPI仕様（旧Swagger仕様）は、REST APIのためのAPI記述形式です

OpenAPIファイルでは下記のようなAPI全体を記述することができる
- 利用可能なエンドポイント(/user)と各エンドポイントでの操作(GET /users, POST /users)
- パラメター操作や入出力
- 認証方法

YAMLまたはJSON形式
- OpenAPIは、RESTfulなAPIをyamlまたはJSON形式で記述することができるフォーマットである


### Swagger

``Swagger Editor``	OpenAPI 定義を記述できるブラウザーベースのエディター。
``Swagger UI``	OpenAPI 定義をインタラクティブなドキュメントとしてレンダリングします。
``Swagger Codegen``	OpenAPI 定義からサーバー スタブとクライアント ライブラリを生成します。


OpenAPIに記述した内容でデータのやり取りができるようにモックサーバーをあらかじめ作成するする

モックサーバーを使うことでサーバー側の環境を構築せずともOpenAPIのファイルがあれば仮想のデータ通信をフロント側で試すことができる。

###### 最終的に
- モックサーバーで``/api/v1/hello``を叩くと``hello``というレスポンスが返ってくる


- docker-compose.ymlに追加
```
 prism:
    image: stoplight/prism:4
    command: 'mock -h 0.0.0.0 /src/openapi/api/openapi.yaml'
    volumes:
      - ./src/openapi/api/openapi.yaml:/src/openapi/api/openapi.yaml:ro
    ports:
      - '4010:4010'

```

###### Dockerで用意されているPrismを利用
- PrismはOSSのモック&プロキシサーバで、OpenAPIドキュメントを使用してモックサーバを起動することができます。

[モックサーバについて](https://fintan-contents.github.io/spa-restapi-handson/todo/frontend/mock/)

OpenAPIファイルを作成

```
openapi: "3.0.3"

info:
  title: "Sample API"
  version: "1.0.0"

paths:
  "/api/v1/hello":
    get:
      summary: "hello"
      responses:
        "200":
          description: "成功"
          content:
            application/json:
              schema:
                type: string
                example: "hello"


```
docker立ち上げとともに起動


dockerの立ち上げに手間取った

---

#### 🧭 実施内容：
- openapiの知識を深める

#### ⌛ 所要時間：
- 30

#### 💡 気づき・課題・感想：

OpenAPIのデータの型
OpenAPIでは下記の6パターンの型が用意されています。

|型 |説明|
|----|------|
|integer|整数|
|number	|浮動小数点|
|string	|文字列|
|boolean|真偽値|
|array	|配列|
|object |オブジェクト|

integer型は下記のフォーマットに分類
|フォーマット	|説明|
|----|------|
|int32	|符号付き32ビット整数|
|int64	|符号付き64ビット整数|

number型は下記のフォーマットに分類
|フォーマット	|説明|
|----|----|
|float	|浮動小数|
|double	|倍精度浮動小数|

string型は下記のフォーマットに分類
|フォーマット	|説明|
|---|----|
|date	|RFC3339(例: 2022-11-06)|
|date-time	|RFC3339(例: 2022-11-06T19:20:30+01:00)|
|email	|メールアドレス|
|password	|パスワード|
|uuid	|uuid|


```
openapi: 


info: {}

paths: {}

servers: {}

tags: {}

paths: {}

components: {}
```

#### openapi
- 使用するOpenAPIのバージョン

#### info
- API自体のメタデータを定義
|フィールド	|型	|説明|
|-----|-----|----|
|title	|string	|APIのタイトル|
|description	|string|	APIの説明。マークダウンも可能|
|version	|string	|APIドキュメントのバージョン|

#### servers
- APIを提供しているサーバーを定義

開発環境や本番環境のURL情報を記載

サーバーは開発環境、本番環境など複数定義する可能性があることからハイフンを利用して配列で表現していく

|フィールド	|型	|説明|
|----|----|----|
|url	|string	|APIを提供しているサーバーのURL|
|description	|string	|提供しているサーバーの情報|


```
openapi: "3.0.3"

info:
  title: "サンプルAPI"
  description: "サンプルとして作成したAPIです"
  version: "1.0.0"

servers:
- url: "http://localhost:3000"
  description: "ローカル環境"
- url: "http://sample.com"
  description: "本番環境"

```


---
### 2025/05/13 スキーマ詳細
#### ✅ 手法：
- OpenAPI 

#### 🧭 実施内容：
- openapi.yamlの中身

#### ⌛ 所要時間：
-　

#### 💡 気づき・課題・感想：
- Swagger Viewerという拡張機能の有用性に気づいた

##### tags
APIを整理するためのタグを配列で定義することができる。

|フィールド|	型	|説明|
|---|---|--|
|name	|string|	タグ名|
|description|	string	|タグの説明|


###### paths
pathsではAPIとして利用できるパスと操作を定義していきます。

pathsは下記の構成で成り立っています。

メタデータ
リクエストパラメータ
リクエストボディー
レスポンス
pathsの内容を一つずつ確認していきます。

##### メタデータ
メタデータの構成は下記です。

|フィールド|	型	|説明|
|----|----|---|
|summary|	string	|操作の概要|
|description	|string	|操作の詳細説明|
|tags|	[string]	|タグを付与できる|
|deprecated	|boolean|	廃止になったかを定義する|


##### リクエストパラメータ
リクエストパラメータは下記の構成になっています。

|フィールド|	型|説明|
|----|----|---|
|name	|string	|パラメータ名を指定する|
|in|	string|	パラメータの場所を指定する(query,header,path,cookie)|
|description	|string	パラメータに関する説明を記載する|
|required	|boolean	|パラメータが必須かを定義する|
|schema|	object|	パラメータお型定義をする。JSONスキーマを元にした記述|
|example	|	サンプルデータを記述|

##### リクエストボディ
リクエストボディは下記の構成になっています。

|フィールド|	型	|説明|
|----|-----|----|
|description	|string|	リクエストボディの説明|
||required	|boolean	|必須項目の判定|
|content	|object|	リクエストボディの内容|
|content.{media}	|object	|メディアタイプをキーにレスポンスボディを定義|
|content.{media}.schema	|object|	リクエストボディを定義|
リクエストボディを定義するcontentは下記の構成を持っています。

メディアタイプ(application/json等)
schemaで型定義
exampleでサンプルデータを記述
記事を新規投稿するAPIを作成しながらリクエストボディについて確認していきます。

下記のデータを新規投稿する。


##### レスポンス
レスポンスは下記の構成になっています。

レスポンスはステータスコード毎にオブジェクトを作成していく。成功ステータスは最低限入れるようにする。

|フィールド|	型	|説明|
|----|---|---|
|description|	string	|レスポンス内容の説明|
|headers	|string	|レスポンスのヘッダー(descriptionとschemaを持つ)|
|content	|object	|具体的に返すデータ|


##### commponents
レスポンスの箇所で使っていたcomponentについて詳しく説明します。

コンポーネントでは下記の6つの要素で成り立っています。

schemas
parameters
requestBodies
responses
headers
SecuritySchemas
componentを参照するときは$refで呼び出します。

記事に対してのコメントを取得と新規作成するAPIを作成しながら確認していきます。

GETでオブジェクト配列型のデータが返ってくる
POSTで投稿したオブジェクトのデータが返ってくる


#### security
OpenAPIで定義できる認証認可は下記。

|種別|	形式	|説明|
|---|---|---|
|http	|Basic	|Basic認証|
|http|	Bearer|	JWTを利用した認可|
|apikey|	header|	APIkeyを利用した認可|
|apikey	|cookie	|ログインセッション|
|oauth2|	-	|OAuth2.0|
セキュリティーはコンポーネントに定義していきます。

Securityschemes
セキュリティースキームの名前
スキームの説明
種別
スキーマの定義

理解むすい
拡張機能エラーが起きてしまう現象があった
ちょっとドキュメント全部描くの大変？
見た目は良き

#### ✅ 手法：
- openapi

#### 🧭 実施内容：
- 本のAPIを作成

#### ⌛ 所要時間：
- 

#### 💡 気づき・課題・感想：
- 

---

---

### 2025-05-15 本番のapi

#### ✅ 手法：
- openapi

#### 🧭 実施内容：
- API設計

#### ⌛ 所要時間：
- 

#### 💡 気づき・課題・感想：
- スキーマ定義を行った
- 配列とタイムで手こずった
- 大きなむずいところはあんまりない

---
### 2025-05-20 本番のapi

#### ✅ 手法：
- openapi

#### 🧭 実施内容：
- API設計

#### ⌛ 所要時間：
- 

#### 💡 気づき・課題・感想：
- エンドポイントの作成思っていたよりも簡単
- node.jsの時間にしてたからかな
- /booksで同じの時getpostは同じ場所に書くべきだった

# VSCodeでのOpenAPI + Swaggerviewerの使い方・メリットまとめ

---

## swaggerviewer:openapi の役割

- **OpenAPI仕様チェックが自動で行われる**  
  → 書いたAPI定義（openapi.yaml）が正しい形式かどうか、エラーや警告がすぐわかる。  
  → 例：「必須項目が抜けてる」「型が間違ってる」などのミスを早期発見できる。

- **補完（オートコンプリート）が効く**  
  → YAMLを書くときに、使えるキーや値の候補を自動で出してくれるから書きやすくなる。

- **Swaggerviewerなどの拡張機能と連携しやすくなる**  
  → SwaggerviewerはOpenAPIをわかりやすく見るためのツールで、VSCode内でプレビューや検証がスムーズにできる。

---

## VSCodeでのOpenAPI + Swaggerviewerの使い方例

1. **OpenAPIのYAMLを作成・編集する**

   ```yaml
   openapi: 3.0.3
   info:
     title: サンプルAPI
     version: 1.0.0
   paths:
     /books:
       get:
         summary: 本一覧を取得
         responses:
           '200':
             description: 正常終了
             
- APIの仕様を書いていく  
  → VSCodeが補完を出してくれるので、書き間違いが減る。

- Swaggerviewer拡張でAPIの見た目を確認  
  → VSCodeのSwaggerviewer拡張を開く  
  → 先ほど作ったYAMLファイルを指定（`yaml.schemas`設定が役立つ）  
  → ブラウザのようにAPI仕様をきれいに見られる。

- モックサーバーを使って動作確認も可能  
  → Prismなどのモックサーバーを設定すれば、API仕様通りのレスポンスを返すテスト環境が作れる。  
  → フロントエンドや他のチームメンバーがAPI仕様に合わせて動作確認しやすくなる。

- 開発中にエラーや警告をリアルタイムチェック  
  → YAMLの書き方に問題があれば、VSCodeがすぐ教えてくれる。  
  → 例：「パスの記述がおかしい」「必須項目がない」など。


ーーー
### 2025-05-29 grpcの理解

#### ✅ 手法：
- grpc

#### 🧭 実施内容：
- 勉強

#### ⌛ 所要時間：
- 約1時間

#### 💡 気づき・課題・感想：
- gRPCのスキーマ定義はProtocol Buffersと呼ばれるインタフェース定義言語（IDL）によって記述されます。Protocol Buffersの例は次のようなものになります。
```
service Greeter {
  rpc SayHello (HelloRequest) returns (HelloReply) {}
}
message HelloRequest {
  string name = 1;
}
message HelloReply {
  string message = 1;
}
```

[参考サイト]
(https://medium.com/sprocket-inc/grpc%E3%81%AE%E3%82%B9%E3%82%AD%E3%83%BC%E3%83%9E%E8%A8%AD%E8%A8%88%E3%81%8A%E3%82%88%E3%81%B3%E5%AE%9F%E8%A3%85%E3%81%AE%E3%83%99%E3%82%B9%E3%83%88%E3%83%97%E3%83%A9%E3%82%AF%E3%83%86%E3%82%A3%E3%82%B9-c0599edcb6f7)

gRPCでは1つのRPC定義をメソッドと呼び、記述方法もプログラミング言語でよく見られるメソッド定義のような見た目となっています。

* リクエストのリトライ処理をシンプルに保てる。
* 分散システムによるリクエストの重複を考慮する必要がなくなる。

Protocol Buffersにはデータ型としてenumがサポートされています。enum型を定義する際のベストプラクティスは以下があります。
* UNSPECIFIEDを0番目の要素として用意する。
* enumの各要素の名前はパッケージ内において一意にする。
```enum Color {
  COLOR_UNSPECIFIED = 0;  // Default value
  COLOR_RED = 1;
  COLOR_GREEN = 2;
  COLOR_BLUE = 3;
}
```
通常null=0
enum 
最初の要素がデフォルトに
エラーが出ないようデフォルト値を指定しておく

gRPCサーバーをGo言語で実装する場合の注意点として、メッセージからフィールドを取り出す際にGetterメソッドを使用してnil-safeにするというものがあります。Getterメソッドを使用せずにフィールドを取り出すと意図せずnil pointer dereferenceによるpanicを発生させてしまう場合があります。以下のようなメッセージを考えます。

```
message Request {
  Entry entry = 1;
}
message Entry {
  string title = 1;
  string body = 2;
}
```
```struct Request {
  Entry *Entry
}
struct Entry {
  Title string
  Body  string
}```
```func (x *Request) GetEntry() *Entry {
  if x != nil {
    return x.Entry
  }
  return nil
}
func (x *Entry) GetTitle() string {
  if x != nil {
    return x.Title
  }
  return ""
}```

[参考サイト](https://qiita.com/HitoroOhria/items/a4e06a3e7e8c8dfef4df)

gRPC とは何か？
gRPC とは、以下の2つを実現する RPC フレームワークである。

* 高速な API 通信
* スキーマ駆動家初
現在、マイクロサービス間の内部通信の実現方法として有力視されている。

gRPC の長所は何か？
① HTTP/2 による高速通信
gRPC では HTTP/2 を採用しており、 HTTP/1.1 を採用する REST よりも高速である。
HTTP/2 ではデータ形式はバイナリであり、コネクションの接続・切断を都度行わなくて良い点が特徴である。

② スキーマ駆動開発による高生産性
gRPC では Protocol Buffers を採用している。
Protocol Buffers ではスキーマを定義し、コードを自動生成する。

スキーマ定義 → 自動生成の仕組みにより、API ドキュメントの管理が不要となる。
スキーマ = API ドキュメントとなるためである。

クラアントがサービスを利用したい場合、スキーマを見ればすべて書いてある。
バックエンドがサービスを追加・変更したい場合、スキーマを書けばコードを自動生成できる。


(.proto ファイルの書き方)[https://qiita.com/HitoroOhria/items/b3f64e072e94e99cb554]
Protocol Buffers では、スキーマは *.proto というファイルに独自の IDL で記述する。
```syntax = "proto3";

package myapp;

service AddressBookService {
  rpc Search (SearchRequest) returns (SearchResponse);
}

message SearchRequest {
  string name = 1;
}

message SearchResponse {
  Person person = 1;
}

message Person {
  int32 id = 1;
  string name = 2;
  string email = 3;
}```
gRPC サーバー実装
Go を利用する場合、以下の3つのパッケージが必要である。

コンパイラ
protoc
コードジェネレータ
protoc-gen-go
protoc-gen-go-grpc

 言語非依存のRPCフレームワークで、以下のような多くのプログラミング言語に対応

インストール

brew install protobuf
```
---

### 2025-06-10 grpc

#### ✅ 手法：
- grpc

#### 🧭 実施内容：
- 

#### ⌛ 所要時間：
- 

#### 💡 気づき・課題・感想：
- .proto ファイルは gRPCの“契約書”`
あなたとマシンとが交わす「約束ごと」——言うなれば技術の書状
- 設計図（proto）をもとに、プログラムの“部品”を自動生成

### コード生成コマンド
protoc --go_out=. --go-grpc_out=. book.proto

###### コードを生み出す「protoc」の導入
# 1. Protocol Buffers コンパイラ（protoc）をインストール
brew install protobuf

# 2. GoのgRPCプラグインを導入
go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest

# 3. $PATH にGoのbinパスを通す（まだであれば）
export PATH="$PATH:$(go env GOPATH)/bin"

「取得する」と「返す」の違い
取得する は、あなた（クライアント）がサーバーに「データをください」ってリクエストを送ること

返す は、サーバーが「はい、これが requested データですよ」ってレスポンスを返すこと
```
rpc GetBook(GetBookRequest) returns (GetBookResponse);
```

* GetBookRequest → クライアントが「どの本が欲しいか」指定するデータ

* GetBookResponse → サーバーが「これがその本ですよ」って返すデータ

「クライアントが本のIDを指定して（取得をリクエスト）、サーバーがその本の詳細情報を返す」

クライアント側は「こういう情報ほしいよ！」ってリクエストを作って送る

サーバー側は「はい、これが欲しい情報ですよ！」ってレスポンスを返す

このやりとりのルール（インターフェース）を .proto で定義
だから
.proto ファイルは「どんなメッセージをやりとりするか」や「どんなRPCメソッドがあるか」を決めている場所

実際にその定義をもとに、クライアントもサーバーもGoのコードとか他の言語のコードに自動変換（コード生成）して使う

-----

今の現状
コードはgrpcでバックのコードが自動化された
使い分けのイメージ
OpenAPIモック（Prism）
→ API仕様検証やフロント開発のスタブとして使いやすい
→ サーバー実装がまだない段階や動作確認に便利

gRPCサーバー（Go実装）
→ 実際のビジネスロジックを動かしたいとき
→ APIの挙動確認やサービス間通信のテストに使う

もしクライアントがReactなどでOpenAPIクライアントを使うなら、モックを先に使ってUI作るのもよいし、gRPCクライアント作って実装と通信確認もできるので、2つをうまく使い分ける感じ

今は

バックエンドはモック（OpenAPI Prism）や最低限のgRPCサーバーがある状態

まだ本格的なビジネスロジックは未実装

なので、

これからやること例
フロント側のUIやAPI呼び出し部分を書いて、動作確認する

モックサーバーを使いながらフロントの開発を進める（仕様変更もここで気づける）

フロントがある程度できてから、必要なバックエンドロジックを実装していく


#### ✅ 手法：
- フロントエンド

#### 🧭 実施内容：
二つのモックサーバを用いて
フロントエンドのコードを作成する

| サーバー種類                  | 説明                       | ポート     | アクセス方法                    |
| ----------------------- | ------------------------ | ------- | ------------------------- |
| OpenAPIモックサーバ（Prism） | OpenAPI仕様に基づくモックHTTP API | `3001`  | `http://localhost:3001`   |
| gRPCサーバ（Go）          | 実装されたgRPCサーバー            | `50051` | `localhost:50051`（gRPC専用） |

grpcはHTTPじゃなくて gRPCプロトコルで通信する
フロントから使うには → gRPC-Web 経由でアクセスするようにする必要あり（セットアップが必要）

| やりたいこと           | 今すぐできる？         | 備考                                                               |
| ---------------- | --------------- | ---------------------------------------------------------------- |
| OpenAPIモックでの画面作成 |  できる           | `fetch()` で [http://localhost:3001](http://localhost:3001) にアクセス |
| gRPCを直接叩く        | grpcurlで確認OK | 実装はできてるが、フロント連携はまだ                                               |
| gRPC + フロント連携    | もう一歩         | gRPC-Web か Gateway の設定が必要                                        |

### 2025-06-17 grpcでのフロント連携

#### ✅ 手法：
- grpc

#### 🧭 実施内容：
- 

#### ⌛ 所要時間：
---

## 🚧 なぜgRPCにEnvoyが必要なのか？通訳にたとえて理解！

---

### 🎓 まず前提：gRPCがそのままブラウザで使えない理由

gRPCは **HTTP/2 + バイナリ通信** を前提とした高速プロトコルです。

でも、ブラウザ（Reactなど）は **HTTP/1.1 + テキスト** にしか対応していません。

---

### 💬 例え話：

あなたが「**フランス語しか話せない人（＝gRPCサーバ）**」だとします。
でも、ブラウザ（React）は「**日本語しか話せない人**」。

---

| 人物          | 使える言語 | 実際のプロトコル                    |
| ----------- | ----- | --------------------------- |
| gRPCサーバ     | フランス語 | HTTP/2 + バイナリ形式（gRPC）       |
| React（ブラウザ） | 日本語   | HTTP/1.1 + テキスト形式（gRPC-Web） |

---

👉 お互いに「言葉（プロトコル）」が違うので、**直接は会話できません！**

---

### 👷‍♀️ そこで登場するのが「通訳」＝Envoy

Envoyは「**フランス語も日本語も分かる通訳者**」のような存在です。

---

#### 🔁 通信の流れ（訳しながら話すイメージ）

```
ブラウザ「こんにちは！」（HTTP/1.1 + gRPC-Web）
  ↓
Envoy「Bonjour！」（HTTP/2 + gRPC）に翻訳してgRPCサーバに送信
  ↓
サーバの返事をまた日本語に訳してブラウザに返す
```

---

### 📦 Envoy は Dockerコンテナで動かすのが一般的

---

### 🔧 Envoy構成のイメージ（図で）

```
🧑（React）          HTTP/1.1 + gRPC-Web
     ↓
🧑‍💼（Envoy）        HTTP/2 + gRPC
     ↓
🧑‍🔬（Go gRPCサーバ）
```

---

### 🗂️ envoy.yaml = 通訳への指示書！

Envoyには「**どんな言語を訳すのか？誰に向けて訳すのか？**」を教えてあげる必要があります。
それが **`envoy.yaml`** です！

たとえば：

```yaml
# envoy.yaml のイメージ
- 8080ポートでブラウザからのHTTPを受ける
- gRPC-Webで来たら、50051のgRPCサーバにHTTP/2で中継する
```

---

## 💡 よくある質問

---

### Q. gRPC-WebってgRPCとどう違うの？

| プロトコル    | 通信方式     | データ形式         |
| -------- | -------- | ------------- |
| gRPC     | HTTP/2   | バイナリ          |
| gRPC-Web | HTTP/1.1 | base64エンコードあり |

📝 → **中身の形式は近いけど、通信方式が違う！**
gRPC-Webは**ブラウザ向けに加工されたgRPC**と考えよう。

---

### Q. なぜ `host.docker.internal` を使うの？

Envoyが**Docker内で動いていて**、GoのgRPCサーバが\*\*ホストPC上（localhost:50051）\*\*にあるとき、
**Dockerから「ホストのlocalhost」を参照するための特別なアドレス**が必要だからです。

| OS            | アクセス方法                  |
| ------------- | ----------------------- |
| macOS/Windows | `host.docker.internal`  |
| Linux         | `172.17.0.1` や bridge経由 |

---

## 🏁 最終イメージ（通信の流れ）

```
① ブラウザでReactアプリ起動（例: http://localhost:3000）

② ブラウザ → http://localhost:8080 にgRPC-Webでリクエスト送信

③ Envoyが受信 → HTTP/2に変換してGoのgRPCサーバ（localhost:50051）に転送

④ サーバからレスポンス

⑤ EnvoyがgRPC-Web形式に再変換してブラウザに返す
```

---

## 🪄 最後に一言（感覚で理解）

> **「gRPC + Envoy」は、通訳を挟んで海外の人と電話するようなもの！**

通訳（Envoy）がいなければ会話できないけど、
一度通訳を通せば、あたかも普通に話しているように使える！

- 


`grpc-〇〇` のように、「gRPCの拡張」「対応プラットフォーム向け」「gRPCの周辺ツール」として登場しているライブラリ・プロトコル・プロジェクトがいくつもあります。

---

##  よく使われる gRPCファミリー（grpc-〇〇）

---

###  フロントエンド・Web向け

| 名前               | 説明                                                        |
| ---------------- | --------------------------------------------------------- |
| **grpc-web**     | ブラウザ（JavaScript/TypeScript）からgRPCを使うためのプロトコル。Envoyなどが必要。  |
| **grpc-gateway** | REST⇔gRPCの変換を自動でやってくれるGo製ゲートウェイ。REST APIを使いたいクライアント向けに便利。 |

---

###  言語・バインディング関係

| 名前                      | 説明                                  |
| ----------------------- | ----------------------------------- |
| **grpc-go**             | Go向けgRPC公式実装                        |
| **grpc-java**           | Java/Kotlin向け                       |
| **grpc-node**           | Node.js（JavaScript/TypeScript）向け    |
| **grpc-swift**          | Swift/iOS向け公式ライブラリ（Apple製）          |
| **grpc-dotnet**         | .NET Core/C#向け                      |
| **grpc-python**         | Python向け                            |
| **grpc-rs** / **tonic** | Rust向けのgRPCライブラリ（公式とコミュニティ主導の両方がある） |

---

###  通信プロトコル/変換

| 名前                | 説明                                                                    |
| ----------------- | --------------------------------------------------------------------- |
| **grpc-web**      | HTTP/1.1ベース、ブラウザ用gRPC                                                 |
| **grpc-gateway**  | gRPC⇔REST API変換                                                       |
| **grpc-mux**      | 複数のgRPCサービスを1つのポートで提供する仕組み（内部設計寄り）                                    |
| **grpc-web-text** | `Content-Type: application/grpc-web-text` の形式。base64でエンコードされたgRPC-Web |

---

###  デバッグ・インフラ

| 名前                    | 説明                                    |
| --------------------- | ------------------------------------- |
| **grpcurl**           | curlっぽくgRPCを叩けるCLIツール（開発・デバッグで超便利）    |
| **evans**             | gRPC CLIツール。gRPCサーバと対話的にやり取り可能（REPL風） |
| **grpc-health-probe** | gRPCサーバのヘルスチェック用                      |
| **grpcui**            | ブラウザ上でgRPCを操作できるGUI。grpcurlと似てるがGUI版。 |

---

###  テスト・観測

| 名前                   | 説明                                             |
| -------------------- | ---------------------------------------------- |
| **grpc-fallback**    | ネイティブgRPCが使えないときにRESTにフォールバックするGoogle Cloudの方式 |
| **grpc-opentracing** | gRPCのトレース用（分散トレーシング向け）                         |

---

##  まとめ：gRPCファミリーは用途ごとに豊富

| カテゴリ       | 例                          | 目的                |
| ---------- | -------------------------- | ----------------- |
| Web/REST変換 | grpc-web, grpc-gateway     | ブラウザやREST APIとの接続 |
| 言語対応       | grpc-go, grpc-java, ...    | gRPCを各言語で扱うための実装  |
| ツール系       | grpcurl, grpcui, evans     | CLIやGUIでgRPCを叩く   |
| 観測/診断      | grpc-health-probe, tracing | モニタリングや可観測性       |

---

## 「何を使えばいいの？」ざっくりガイド

* **React（Web）からgRPC使いたい** → `grpc-web + envoy`
* **REST APIも出したい（モバイルやcurlなど向け）** → `grpc-gateway`
* **CLIで手軽に叩きたい** → `grpcurl` or `evans`
* **gRPCの挙動を確認したい** → `grpcui`

