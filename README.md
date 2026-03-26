# devise_mail_app

Devise と ActionMailer を使った認証・メール機能の学習用 Rails アプリケーションです。

## 動作環境

- Ruby 4.0.1
- Rails 8.1.3
- SQLite3

## セットアップ

```bash
# 依存 gem のインストール
bundle install

# データベースの作成
bundle exec rails db:create db:migrate
```

## 起動方法

```bash
bundle exec rails server
```

起動後、ブラウザで http://localhost:3000 にアクセスしてください。停止するには `Ctrl-C` を押します。

## テストの実行

```bash
bundle exec rspec
```

## 主な使用技術

| 技術 | 用途 |
|------|------|
| Rails 8.1.3 | Web フレームワーク |
| SQLite3 | データベース |
| RSpec | テスト |
| ActionMailer | メール送信 |
