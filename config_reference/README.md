# PHP 5.6 + Apache + PHP-FPM 設定ファイル一覧

このディレクトリには、Docker環境で使用しているPHP-FPM関連の設定ファイルが保存されています。

## ファイル一覧

### PHP-FPM 設定
- **php-fpm.conf** - PHP-FPMメイン設定ファイル
  - パス: `/etc/opt/remi/php56/php-fpm.conf`
  - 内容: グローバルなPHP-FPM設定（プロセス管理、ログ設定など）

- **www.conf** - PHP-FPMプール設定
  - パス: `/etc/opt/remi/php56/php-fpm.d/www.conf`
  - 内容: `www`プールの設定（ユーザー、ソケット、プロセス数など）
  - 重要な設定:
    - `user = apache`
    - `group = apache`
    - `listen = /var/opt/remi/php56/run/php-fpm/www.sock`
    - `listen.acl_users = apache`

### Apache 設定
- **apache-php56.conf** - Apache PHP-FPM連携設定
  - パス: `/etc/httpd/conf.d/php56-php.conf`
  - 内容: ApacheからPHP-FPMへの接続設定
  - ProxyPassによるUnixソケット経由のFastCGI設定

- **httpd.conf** - Apacheメイン設定
  - パス: `/etc/httpd/conf/httpd.conf`
  - 内容: Apache 2.4のメイン設定ファイル

### PHP 設定
- **php.ini** - PHP設定ファイル
  - パス: `/etc/opt/remi/php56/php.ini`
  - 内容: PHP 5.6のランタイム設定

## 構成概要

```
Apache (httpd)
    ↓ (Unix Socket)
PHP-FPM (/var/opt/remi/php56/run/php-fpm/www.sock)
    ↓
PHP 5.6.40 (Remi Repository)
```

## 参考情報

- OS: AlmaLinux 8 (CentOS 8互換)
- PHPソース: Remi Repository (el8.remi)
- PHPバージョン: 5.6.40
- 起動方式: PHP-FPM + Apache (ProxyPass経由)

## 更新日

2026年1月15日
