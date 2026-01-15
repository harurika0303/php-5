# Smartyバージョン判定ガイド

## コードから判断する方法

### 1. PHPコード側のチェックポイント

#### Smarty 2.x の特徴
```php
// プロパティ直接代入
$smarty->template_dir = './templates/';
$smarty->compile_dir = './templates_c/';
$smarty->config_dir = './configs/';
$smarty->cache_dir = './cache/';

// 古い書き方
$smarty->assign_by_ref('var', $value);
$smarty->register_function('func', 'callback');
```

#### Smarty 3.x の特徴
```php
// セッターメソッド使用
$smarty->setTemplateDir('./templates/');
$smarty->setCompileDir('./templates_c/');
$smarty->setConfigDir('./configs/');
$smarty->setCacheDir('./cache/');

// 新しい書き方
$smarty->registerPlugin('function', 'func', 'callback');
```

### 2. テンプレート(.tpl)側のチェックポイント

#### Smarty 2.x で使われていた構文
```smarty
{* PHPコードが直接使える *}
{php}
  echo "PHP code here";
{/php}

{* 比較演算子 *}
{if $var eq "value"}
{if $var neq "value"}
{if $var gt 10}

{* includeの書き方 *}
{include file="header.tpl" title="Page"}

{* セクション構文 *}
{section name=item loop=$items}
  {$items[item].name}
{/section}
```

#### Smarty 3.x の構文
```smarty
{* PHPコードはデフォルトで無効 *}

{* 通常のPHP演算子 *}
{if $var == "value"}
{if $var != "value"}
{if $var > 10}

{* 短縮構文が使える *}
{include "header.tpl" title="Page"}

{* foreach推奨 *}
{foreach $items as $item}
  {$item.name}
{/foreach}

{* 新機能 *}
{$var|escape}
{$var nofilter}
```

### 3. 機能の有無で判断

| 機能 | Smarty 2.x | Smarty 3.x |
|------|-----------|-----------|
| `{php}` タグ | ○ | × (設定で有効化可) |
| `$smarty.now` | ○ | ○ |
| `{function}` タグ | × | ○ |
| `{block}` 継承 | × | ○ |
| オブジェクトメソッド | 限定的 | 完全対応 |

### 4. 実際のチェック手順

```bash
# 1. requireパスを確認
grep -r "require.*Smarty" .

# 2. セッターメソッドの使用を確認
grep -r "setTemplateDir\|template_dir" .

# 3. テンプレートで{php}タグを検索
grep -r "{php}" templates/

# 4. 比較演算子を確認
grep -r " eq \| neq \| gt \| lt " templates/

# 5. バージョン定数を検索
grep -r "SMARTY_VERSION\|_version" .
```

### 5. 実行環境での確認方法

```php
<?php
require_once 'Smarty.class.php';
$smarty = new Smarty();

// バージョン確認
if (defined('Smarty::SMARTY_VERSION')) {
    echo "Smarty 3.x: " . Smarty::SMARTY_VERSION;
} else {
    echo "Smarty 2.x: " . $smarty->_version;
}
?>
```

## 互換性の問題

### Smarty 2→3への移行で必要な変更

1. **プロパティ → メソッド**
   ```php
   // Before (2.x)
   $smarty->template_dir = './templates/';
   
   // After (3.x)
   $smarty->setTemplateDir('./templates/');
   ```

2. **比較演算子**
   ```smarty
   {* Before (2.x) *}
   {if $var eq "test"}
   
   {* After (3.x) *}
   {if $var == "test"}
   ```

3. **{php}タグの削除**
   ```smarty
   {* Before (2.x) *}
   {php}echo date('Y-m-d');{/php}
   
   {* After (3.x) - カスタムプラグインを作成 *}
   {current_date}
   ```

## まとめ

判断の優先順位:
1. **PHPコード内のセッターメソッド使用** → Smarty 3.x確定
2. **`{php}`タグの多用** → Smarty 2.x の可能性大
3. **`eq/neq/gt/lt`演算子** → Smarty 2.x の可能性
4. **`{block}`や`{function}`** → Smarty 3.x確定
5. **実際に動かして確認** → 最終手段
