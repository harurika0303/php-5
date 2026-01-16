<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{$page_title}</title>
    <link rel="stylesheet" href="/css/news.css">
</head>
<body>
    <div class="header">
        <div class="container">
            <h1>{$page_title}</h1>
        </div>
    </div>
    
    <div class="container">
        {if isset($error)}
        <div class="error-message">
            {$error}
        </div>
        {/if}
        
        {if $news_list|@count > 0}
        <div class="news-list">
            {foreach from=$news_list item=news}
            <div class="news-item">
                <div class="news-meta">
                    <span class="news-date">{$news.published_date|date_format:"%Y年%m月%d日"}</span>
                    <span class="news-category">{$news.category}</span>
                </div>
                <h2 class="news-title">{$news.title}</h2>
                <p class="news-content">{$news.content}</p>
            </div>
            {/foreach}
        </div>
        {else}
        <div class="news-list">
            <div class="no-news">
                ニュースはありません
            </div>
        </div>
        {/if}
    </div>
</body>
</html>
