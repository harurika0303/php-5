<?php

/**
 * Smarty動作テスト用ファイル
 * PHP5.6 + Smarty3環境
 */

// タイムゾーン設定
date_default_timezone_set('Asia/Tokyo');

// Smartyライブラリの読み込み
require_once '/usr/share/php/Smarty/Smarty.class.php';

// Smartyインスタンスの作成
/** @var Smarty $smarty */
$smarty = new Smarty();

// ディレクトリ設定
$smarty->setTemplateDir(__DIR__ . '/templates/');
$smarty->setCompileDir(__DIR__ . '/templates_c/');
$smarty->setCacheDir(__DIR__ . '/cache/');
$smarty->setConfigDir(__DIR__ . '/configs/');

// 必要なディレクトリが存在しない場合は作成
$directories = array(
    __DIR__ . '/templates/',
    __DIR__ . '/templates_c/',
    __DIR__ . '/cache/',
    __DIR__ . '/configs/'
);

foreach ($directories as $dir) {
    if (!is_dir($dir)) {
        mkdir($dir, 0777, true);
    }
}

// テンプレートに変数を割り当て
$smarty->assign('message', 'Smartyが正常に動作しています！');
$smarty->assign('timestamp', date('Y-m-d H:i:s'));
$smarty->assign('php_version', phpversion());
$smarty->assign('smarty_version', Smarty::SMARTY_VERSION);

// テンプレートを表示
$smarty->display('test.tpl');
