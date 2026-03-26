# devise_mail_app

Devise と ActionMailer を使った認証・メール機能の学習用 Rails アプリケーションです。

## 動作環境

- Ruby 4.0.1
- Rails 8.1.3
- SQLite3

## 動作環境（追加）

- Node.js 20+（CSS ビルドに必要）

## セットアップ

```bash
# 依存 gem のインストール
bundle install

# npm パッケージのインストール
yarn install

# データベースの作成
bundle exec rails db:create db:migrate
```

## 開発サーバーの起動

```bash
bin/dev
```

Rails サーバーと CSS ウォッチャーが同時に起動します。
ブラウザで http://localhost:3000 にアクセスしてください。停止するには `Ctrl-C` を押します。

> `bin/dev` を使わない場合は、別々のターミナルで以下を実行してください。
> ```bash
> bundle exec rails server   # Rails サーバー
> yarn build:css --watch     # CSS の自動ビルド
> ```

## テストの実行

```bash
bundle exec rspec
```

## CSS のビルド

```bash
yarn build:css
```

`app/assets/stylesheets/application.bootstrap.scss` を編集することで Bootstrap の変数カスタマイズができます。

## 主な使用技術

| 技術 | 用途 |
|------|------|
| Rails 8.1.3 | Web フレームワーク |
| SQLite3 | データベース |
| Devise | 認証（メール確認付き） |
| RSpec | テスト |
| ActionMailer | メール送信 |
| cssbundling-rails + Bootstrap 5 | CSS フレームワーク |
