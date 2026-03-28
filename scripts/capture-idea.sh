#!/bin/bash
# クイックアイデアキャプチャ — セッションを開かずにアイデアを保存する
# 使用法: ./scripts/capture-idea.sh "アイデアタイトル" "詳細（省略可）"
# 例:     ./scripts/capture-idea.sh "B2B向けワークショップ" "企業新入社員研修への哲学組み込み"

TITLE=${1:-""}
DETAIL=${2:-""}
TODAY=$(date '+%Y-%m-%d')
IDEAS_DIR="/home/user/-/秘書/ideas"

if [ -z "$TITLE" ]; then
  echo "使用法: $0 \"アイデアタイトル\" \"詳細（省略可）\""
  exit 1
fi

# ファイル名用に安全な文字列に変換（スペース→ハイフン、日本語はそのまま）
SAFE_TITLE=$(echo "$TITLE" | tr ' ' '-' | head -c 40)
FILE="$IDEAS_DIR/$TODAY-$SAFE_TITLE.md"

mkdir -p "$IDEAS_DIR"

cat > "$FILE" << EOF
# アイデア: $TITLE
日付: $TODAY
カテゴリ: 未分類
ステータス: 未整理

## 概要
$DETAIL

## なぜこれが面白いか
（あとで整理）

## 次のアクション
- [ ] 秘書エージェントで整理・分類する

## 関連アイデア
-
EOF

echo "アイデアを保存しました:"
echo "  $FILE"
echo ""
echo "整理するには: claude -p \"秘書として、$FILE のアイデアを整理してください\""
