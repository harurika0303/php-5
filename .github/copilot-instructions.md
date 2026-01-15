# PHP5.6 + Smarty + MariaDB 環境

## 概要

Docker 環境で PHP5.6 と Smarty を動かすためのテスト環境です。

## コンテナ構成

- **php-app**: AlmaLinux 8 + Remi PHP 5.6 + Smarty
- **db1**: MariaDB
- **db2**: MariaDB

## 使い方

```bash
# コンテナの起動
docker-compose up -d

# コンテナの停止
docker-compose down

# PHPコンテナに入る
docker exec -it php-app bash

# データベースに接続
docker exec -it db1 mysql -uroot -p
```

## 開発

- PHP ファイルは `/var/www/html` に配置
- Smarty テンプレートは適宜配置
- MariaDB は標準ポートで 2 つ起動

## 構成ファイル

- `docker-compose.yml`: コンテナ構成
- `Dockerfile`: PHP 環境のビルド設定
- 必要最小限の構成で動作
