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
$news_list = array();
$error_message = null;

try {
    $pdo = new PDO(
        'mysql:host=db1;dbname=testdb;charset=utf8',
        'root',
        'rootpassword'
    );
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // ニュース取得
    $stmt = $pdo->query('
        SELECT id, title, content, category, author, tags, view_count, published_date 
        FROM news 
        ORDER BY published_date DESC
    ');
    $news_list = $stmt->fetchAll(PDO::FETCH_ASSOC);
} catch (PDOException $e) {
    $error_message = 'データベース接続エラー: ' . $e->getMessage();
}

// データ処理
$total_views = 0;
foreach ($news_list as &$news) {
    $news['formatted_date'] = date('Y年m月d日', strtotime($news['published_date']));
    // タグを配列に分割
    $news['tags'] = !empty($news['tags']) ? explode(',', $news['tags']) : array();
    // 閲覧数を合計
    $total_views += $news['view_count'];
}
unset($news);

// 統計情報を計算
$news_count = count($news_list);
$avg_views = $news_count > 0 ? round($total_views / $news_count) : 0;

// Smartyに変数を割り当て
$smarty->assign('news_list', $news_list);
$smarty->assign('page_title', 'ニュース一覧');
$smarty->assign('news_count', $news_count);
$smarty->assign('total_views', $total_views);
$smarty->assign('avg_views', $avg_views);

if ($error_message) {
    $smarty->assign('error', $error_message);
}

$smarty->display('news_list.tpl');
