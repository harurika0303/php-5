<?php
// エラー表示設定（Deprecatedを非表示）
error_reporting(E_ALL & ~E_DEPRECATED & ~E_STRICT);
ini_set('display_errors', 1);

// タイムゾーン設定
date_default_timezone_set('Asia/Tokyo');

require_once '/usr/share/php/Smarty/Smarty.class.php';

// Smarty初期化
$smarty = new Smarty();
$smarty->template_dir = '/var/www/html/templates';
$smarty->compile_dir = '/var/www/html/templates_c';
$smarty->config_dir = '/var/www/html/configs';
$smarty->cache_dir = '/var/www/html/cache';

// データベース接続
try {
    $pdo = new PDO(
        'mysql:host=db1;dbname=testdb;charset=utf8',
        'root',
        'rootpassword'
    );
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // ニュース取得
    $stmt = $pdo->query('
        SELECT id, title, content, category, published_date 
        FROM news 
        ORDER BY published_date DESC
    ');
    $news_list = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // 日付をPHP側でフォーマット（SmartyのDeprecatedなdate_format修飾子を避けるため）
    foreach ($news_list as &$news) {
        $news['formatted_date'] = date('Y年m月d日', strtotime($news['published_date']));
    }
    unset($news);

    $smarty->assign('news_list', $news_list);
    $smarty->assign('page_title', 'ニュース一覧');
} catch (PDOException $e) {
    $smarty->assign('error', 'データベース接続エラー: ' . $e->getMessage());
    $smarty->assign('news_list', array());
}

$smarty->display('news_list.tpl');
