FROM almalinux:8

# Remiリポジトリのインストール
RUN dnf install -y https://rpms.remirepo.net/enterprise/remi-release-8.rpm epel-release

# PHP 5.6とPHP-FPMのインストール
RUN dnf install -y php56-php php56-php-fpm php56-php-mysqlnd \
    php56-php-mbstring php56-php-xml php56-php-gd httpd \
    && ln -s /opt/remi/php56/root/usr/bin/php /usr/bin/php \
    && ln -s /opt/remi/php56/root/usr/sbin/php-fpm /usr/sbin/php-fpm

# Smartyのインストール (2.6.26)
RUN dnf install -y unzip \
    && mkdir -p /usr/share/php \
    && cd /tmp \
    && curl -L -o smarty.tar.gz https://www.smarty.net/files/Smarty-2.6.26.tar.gz \
    && tar xzf smarty.tar.gz \
    && mv Smarty-2.6.26/libs /usr/share/php/Smarty \
    && rm -rf /tmp/Smarty* \
    && dnf clean all

# エントリーポイントスクリプトをコピー
COPY --chmod=755 entrypoint.sh /entrypoint.sh

# 作業ディレクトリ
WORKDIR /var/www/html

EXPOSE 80

CMD ["/entrypoint.sh"]
