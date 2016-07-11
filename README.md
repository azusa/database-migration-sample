# database-migration-sample

[![wercker status](https://app.wercker.com/status/80f25e6e7d0a999b70bea9241ebafe6e/s/master "wercker status")](https://app.wercker.com/project/bykey/80f25e6e7d0a999b70bea9241ebafe6e)

[Vagrant](https://www.vagrantup.com/) +[Flyway](https://flywaydb.org/)+[SchemaSpy](http://schemaspy.sourceforge.net/)でデータベースのマイグレーションを行うサンプルです。

## 必要な環境
* VirtualBox 5.0.x
* Vagrant 1.8.4
* ruby 2.3.* + Bundler**1.12.5**

Vagrantが組み込みで使用しているBundlerの関係でBundlerはバージョン固定になります。`gem install bundler -v 1.12.5`でインストールしてください。

## セットアップ
```
git clone https://github.com/azusa/database-migration-sample.git
bundle install
vagrant up
```

`vagrant up`コマンドでVMのプロビジョニングを行います。

## プロビジョニングの確認

ServerSpecでプロビジョニングの確認を行います。

```
bundle exec rake
```

## プロビジョニングで作成されるデータベース

使用するRDBMSはPostgreSQL 9.5.1です。

* IPアドレス 192.168.3.2

### データベーススキーマー

| データベース名 | ユーザー名 | パスワード | 用途           |
|:---------------|:-----------|:-----------|:---------------|
| ut             |ut          |ut          |ユニットテスト  |
| development    |development |development |ローカル開発環境|

## テーブルの初期作成
### Windows
```
migration\flyway -password=ut migrate
migration\flyway -password=development -configFile=migration\conf\development.conf migrate
```
### Unix/Mac
```
migration/flyway -password=ut migrate
migration/flyway -password=development -configFile=migration/conf/development.conf migrate
```

`emp`テーブルが作成されます。

## スキーマのドキュメント作成
### Windows
```
bundle exec ruby schemaspy\bin\schemaspy.rb development development
```

### Unix/Mac
```
bundle exec ruby schemaspy/bin/schemaspy.rb development development
```

`build/schema`ディレクトリ下にドキュメントが出力されます。

### データベースマイグレーション

`migration`ブランチをチェックアウトして、`flyway`コマンドを実行すると`dept`テーブルが作成されます。

## License

Apache License, Version 2.0

