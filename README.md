# devise_mail_app

Devise と ActionMailer を使った認証・メール機能の学習用 Rails アプリケーションです。

## 動作環境

- Ruby 4.0.1
- Rails 8.1.3
- SQLite3
- Node.js 20+（CSS ビルドに必要）

## 機能

- メールアドレス・パスワードによるユーザー登録／ログイン
- メールアドレス確認（confirmable）
- パスワードリセット
- アカウント編集・削除
- Bootstrap 5 による日本語 UI
- 開発環境でのメール確認（letter_opener）

## セットアップ

```bash
# 依存 gem のインストール
bundle install

# npm パッケージのインストール
yarn install

# CSS のビルド
yarn build:css

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

## 主な使用技術

| 技術 | 用途 |
|------|------|
| Rails 8.1.3 | Web フレームワーク |
| SQLite3 | データベース |
| Devise | 認証（メール確認付き） |
| RSpec | テスト |
| ActionMailer | メール送信 |
| cssbundling-rails + Bootstrap 5 | CSS フレームワーク |
| Propshaft | アセットパイプライン |
| letter_opener | 開発環境でのメール確認 |
