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
- 

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

---
