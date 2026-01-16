<div class="news-item">
    <div class="news-meta">
        <span class="news-date">{$news.formatted_date}</span>
        <span class="news-category">{$news.category}</span>
        <span class="news-author">投稿者: {$news.author}</span>
        <span class="news-views">👁 {$news.view_count}</span>
    </div>
    <h2 class="news-title">{$news.title}</h2>
    <p class="news-content">{$news.content}</p>
    {if $news.tags}
    <div class="news-tags">
        {foreach from=$news.tags item=tag}
        <span class="tag">{$tag}</span>
        {/foreach}
    </div>
    {/if}
</div>
