{* ニュースアイテムテンプレート - Smarty機能デモ *}

{* 変数の割り当て（assign） *}
{assign var="item_class" value="news-item"}
{if $news.category == '重要'}
    {assign var="item_class" value="news-item important"}
{/if}

<div class="{$item_class}" data-id="{$news.id}">
    {* メタ情報エリア *}
    <div class="news-meta">
        {* 日付表示 *}
        <span class="news-date">{$news.formatted_date}</span>
        
        {* カテゴリ表示（条件分岐） *}
        {if $news.category == 'プレスリリース'}
            <span class="news-category category-press">📢 {$news.category}</span>
        {elseif $news.category == '重要'}
            <span class="news-category category-important">⚠️ {$news.category|upper}</span>
        {elseif $news.category == 'キャンペーン'}
            <span class="news-category category-campaign">🎉 {$news.category}</span>
        {else}
            <span class="news-category">{$news.category}</span>
        {/if}
        
        {* 著者表示（capitalize修飾子） *}
        <span class="news-author">投稿者: {$news.author|capitalize}</span>
        
        {* 閲覧数表示（number_format修飾子） *}
        <span class="news-views">👁 {$news.view_count|number_format:0:'.':','}</span>
    </div>
    
    {* タイトル表示 *}
    <h2 class="news-title">{$news.title|escape}</h2>
    
    {* 本文表示（truncate修飾子で文字数制限） *}
    <p class="news-content">{$news.content|escape|nl2br}</p>
    
    {* 本文の文字数を表示（string_length修飾子） *}
    <div class="news-info">
        <small>文字数: {$news.content|count_characters:true} 文字</small>
    </div>
    
    {* タグ表示（foreach with special variables） *}
    {if $news.tags}
    <div class="news-tags">
        <span class="tags-label">タグ:</span>
        {foreach from=$news.tags item=tag name=tagloop}
            {* @index: 0から始まるインデックス *}
            {* @iteration: 1から始まる反復回数 *}
            {* @first: 最初の要素かどうか *}
            {* @last: 最後の要素かどうか *}
            <span class="tag {if $smarty.foreach.tagloop.first}first-tag{/if}" 
                  data-index="{$smarty.foreach.tagloop.index}">
                #{$tag|trim}
            </span>
            {if !$smarty.foreach.tagloop.last}, {/if}
        {/foreach}
        <span class="tag-count">(全{$smarty.foreach.tagloop.total}件)</span>
    </div>
    {/if}
    
    {* フッター情報 *}
    <div class="news-footer">
        {* 数学演算 *}
        {assign var="popularity" value=$news.view_count/100}
        {if $popularity > 30}
            <span class="popularity high">🔥 人気記事</span>
        {elseif $popularity > 10}
            <span class="popularity medium">📈 注目記事</span>
        {else}
            <span class="popularity low">📄 通常記事</span>
        {/if}
        
        {* IDを表示（記事番号） *}
        <span class="news-id">記事ID: #{$news.id|string_format:"%05d"}</span>
    </div>
</div>
