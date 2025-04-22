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
.
├── openapi/         # OpenAPI を使ったスキーマファースト実装
├── grpc/            # gRPC を使ったスキーマファースト実装
├── code-first/      # コードファーストの実装（例：FastAPI、NestJSなど）
└── README.md

