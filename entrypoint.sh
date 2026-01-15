#!/bin/bash

# PHP-FPMを起動
/opt/remi/php56/root/usr/sbin/php-fpm -D

# Apacheを起動（フォアグラウンド）
exec /usr/sbin/httpd -D FOREGROUND
