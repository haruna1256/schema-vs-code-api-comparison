# schema-vs-code-api-comparison

## 🔍 概要

このリポジトリは、以下の3つのAPI開発手法を比較・検証するためのものです：

- **スキーマ駆動開発（Schema-First）**
  - OpenAPIを用いたREST API設計
  - gRPCを用いたRPC設計
- **コードファースト開発（Code-First）**
  - ソースコードからAPI仕様を生成

それぞれの手法を実装・比較し、開発効率・保守性・チーム開発との相性などを評価・考察します。

---

## 📁 ディレクトリ構成（予定）

```bash
schema-vs-code-api-comparison/
├── client/                # Reactアプリのソースコード
│   ├── Dockerfile         # React用のDockerfile
│   ├── package.json       # Reactのパッケージ設定
│   └── src/               # Reactのソースコード
│       └── ...
├── server/                # サーバー（Go製バックエンド）
│   ├── Dockerfile         # Go用のDockerfile
│   ├── go.mod             # Goのモジュール設定
│   ├── go.sum             # Goのモジュール設定
│   └── main.go            # 共通の起動ファイル
├── docker-compose.yml     # フロント・バックエンドの連携定義
|
├── docs/                # ドキュメント関連（比較結果や進捗メモ）
│   ├── comparison.md    # スキーマ駆動開発 vs コードファースト の比較
│   ├── api-design.md    # 読書記録アプリAPI設計（概要・仕様書）
│   └── experiment-log.md # ゼミでのメモや実験結果
├── src/                 # 実装コード
│   ├── openapi/         # OpenAPIを用いた実装
│   │   ├── api/         # OpenAPI仕様に基づいたエンドポイント
│   │   ├── models/      # モデルやデータ構造
│   │   └── server.js    # サーバーのエントリーポイント
│   ├── grpc/            # gRPCを用いた実装
│   │   ├── proto/       # gRPCの.protoファイル
│   │   ├── services/    # gRPCサービスの実装
│   │   └── server.js    # サーバーのエントリーポイント
│   ├── code-first/      # コードファースト実装
│   │   ├── models/      # モデルの定義
│   │   ├── routes/      # APIルートの定義
│   │   └── server.js    # サーバーのエントリーポイント
│   └── shared/          # 共通のコードやユーティリティ
│       ├── database.js  # データベース接続など
│       └── helpers.js   # ヘルパー関数
├── tests/               # テストコード
│   ├── openapi/         # OpenAPIのテスト
│   ├── grpc/            # gRPCのテスト
│   └── code-first/      # コードファーストのテスト
├── scripts/             # 開発用スクリプト（サーバ起動など）
│   └── start-server.js  # サーバー起動スクリプト
├── .github/             # GitHub ActionsなどのCI/CD設定
│   └── workflows/
│       └── ci.yml       # CI/CDの設定
├── LICENSE              # ライセンス情報
├── README.md            # プロジェクト概要や使い方
└── package.json         # Node.jsの依存関係など


