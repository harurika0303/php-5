<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{$page_title|escape} - ニュース管理システム</title>
    <link rel="stylesheet" href="/css/news.css">
</head>
<body>
    {* ヘッダー部分 *}
    <div class="header">
        <div class="container">
            <h1>{$page_title|upper}</h1>
            {* capture: 変数に出力をキャプチャ *}
            {capture name=subtitle}
                {if $news_count > 0}
                    全{$news_count}件のニュース
                {else}
                    ニュースがありません
                {/if}
            {/capture}
            <p class="subtitle">{$smarty.capture.subtitle}</p>
        </div>
    </div>
    
    <div class="container">
        {* エラーメッセージ表示 *}
        {if isset($error)}
        <div class="error-message">
            {$error|escape}
        </div>
        {/if}
        
        {* ニュース統計情報 *}
        {if $news_count > 0}
        <div class="news-stats">
            <div class="stat-item">
                <span class="stat-label">総記事数:</span>
                <span class="stat-value">{$news_count}件</span>
            </div>
            <div class="stat-item">
                <span class="stat-label">総閲覧数:</span>
                <span class="stat-value">{$total_views|number_format:0:'.':','}回</span>
            </div>
            <div class="stat-item">
                <span class="stat-label">平均閲覧数:</span>
                <span class="stat-value">{$avg_views|number_format:0:'.':','}回</span>
            </div>
        </div>
        {/if}
        
        {* ニュース一覧 *}
        {if $news_count > 0}
        <div class="news-list">
            {* foreach with special variables *}
            {foreach from=$news_list item=news name=newsloop}
                {* コメント: 5件ごとに広告枠を挿入する例 *}
                {if $smarty.foreach.newsloop.iteration is div by 5 && !$smarty.foreach.newsloop.last}
                    <div class="ad-space">
                        <p>🎯 広告枠</p>
                    </div>
                {/if}
                
                {* 個別ニューステンプレートをインクルード *}
                {include file="news_item.tpl" news=$news}
                
                {* 最初の記事の後にお知らせを表示 *}
                {if $smarty.foreach.newsloop.first}
                    <div class="notice-banner">
                        ℹ️ 最新のニュースをチェックしましょう！
                    </div>
                {/if}
            {/foreach}
        </div>
        
        {* ページネーション風の表示 *}
        <div class="pagination-info">
            表示中: 1-{$news_count} / 全{$news_count}件
        </div>
        
        {else}
        {* ニュースがない場合 *}
        <div class="news-list">
            <div class="no-news">
                <p>📭 ニュースはありません</p>
                <small>新しいニュースが投稿されるまでお待ちください</small>
            </div>
        </div>
        {/if}
    </div>
    
    {* フッター *}
    <footer class="footer">
        <div class="container">
            {* literal: Smartyタグとして解釈されない *}
            {literal}
            <p>表示例: {$variable} はそのまま表示されます（literalブロック内）</p>
            {/literal}
            <p><small>&copy; 2025 ニュース管理システム | 最終更新: {$smarty.now|date_format:"%Y年%m月%d日"}</small></p>
        </div>
    </footer>
</body>
</html>
