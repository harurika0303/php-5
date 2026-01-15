FROM almalinux:8

# Remiリポジトリのインストール
RUN dnf install -y https://rpms.remirepo.net/enterprise/remi-release-8.rpm \
    && dnf install -y epel-release

# PHP 5.6とPHP-FPMのインストール
RUN dnf install -y php56-php php56-php-fpm php56-php-mysqlnd \
    php56-php-mbstring php56-php-xml php56-php-gd httpd

# Smartyのインストール
RUN dnf install -y wget unzip \
    && mkdir -p /usr/share/php \
    && cd /tmp \
    && wget https://github.com/smarty-php/smarty/archive/refs/tags/v3.1.39.zip \
    && unzip v3.1.39.zip \
    && mv smarty-3.1.39/libs /usr/share/php/Smarty \
    && rm -rf v3.1.39.zip smarty-3.1.39

# PHP 5.6をデフォルトに設定
RUN ln -s /opt/remi/php56/root/usr/bin/php /usr/bin/php

# エントリーポイントスクリプトをコピー
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# 作業ディレクトリ
WORKDIR /var/www/html

EXPOSE 80

CMD ["/entrypoint.sh"]
