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
            {include file="news_item.tpl" news=$news}
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
