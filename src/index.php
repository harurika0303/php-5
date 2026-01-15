<?php

/**
 * PHP + MariaDB 接続テスト
 * 
 * このスクリプトは2つのMariaDBコンテナ(db1, db2)への接続を確認し、
 * それぞれのバージョン情報を表示します。
 */

echo "<h1>PHP + MariaDB 接続テスト</h1>";

// 接続先データベースの定義
// キー: ホスト名（Dockerコンテナ名）、値: データベース名
$databases = ['db1' => 'testdb1', 'db2' => 'testdb2'];

// 各データベースに接続してバージョンを確認
foreach ($databases as $host => $dbname) {
    echo "<h2>{$host}</h2>";
    
    // データベースに接続（user: root, password: root）
    $conn = mysqli_connect($host, 'root', 'root', $dbname);
    
    if ($conn) {
        // 接続成功: MariaDBバージョンを取得して表示
        $result = mysqli_query($conn, "SELECT VERSION()");
        $version = mysqli_fetch_row($result)[0];
        echo "<p style='color: green;'>✓ {$version}</p>";
        mysqli_close($conn);
    } else {
        // 接続失敗: エラーメッセージを表示
        echo "<p style='color: red;'>✗ 接続失敗</p>";
    }
}

// PHP環境の詳細情報を表示
echo "<hr><h2>PHP情報</h2>";
phpinfo();
