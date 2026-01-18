#!/bin/bash

# PHP-FPMを起動
php-fpm -D

# Apacheを起動(フォアグラウンド)
exec httpd -D FOREGROUND
