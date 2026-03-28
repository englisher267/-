#!/bin/bash
# 哲鉄日々 朝のブリーフィング — SessionStartフック
# セッション開始時にCEOへのコンテキストを注入する

TODAY=$(date '+%Y-%m-%d')
TASKS_DIR="/home/user/-/秘書/tasks"
IDEAS_DIR="/home/user/-/秘書/ideas"
TODAY_FILE="$TASKS_DIR/$TODAY.md"

echo "=== 哲鉄日々 朝のブリーフィング ==="
echo "日付: $TODAY"
echo ""

# 今日のタスクファイルを確認
if [ -f "$TODAY_FILE" ]; then
  PENDING=$(grep -c "^\- \[ \]" "$TODAY_FILE" 2>/dev/null || echo 0)
  DONE=$(grep -c "^\- \[x\]" "$TODAY_FILE" 2>/dev/null || echo 0)
  echo "## 今日のタスク状況"
  echo "未完了: ${PENDING}件 / 完了: ${DONE}件"
  echo ""
  echo "### 未完了タスク"
  grep -E "^\- \[ \]" "$TODAY_FILE" 2>/dev/null | head -5 || echo "（なし）"
else
  echo "## 今日のタスクファイルがありません"
  echo "→ 秘書エージェントに作成を依頼してください"
fi

echo ""

# 直近のアイデア（最新3件）
echo "## 直近のアイデア"
if ls "$IDEAS_DIR"/*.md 2>/dev/null | head -3 | grep -q .; then
  ls -t "$IDEAS_DIR"/*.md 2>/dev/null | head -3 | while read f; do
    echo "- $(basename "$f" .md)"
  done
else
  echo "（まだアイデアは保存されていません）"
fi

echo ""
echo "---"
echo "CEOへ: 上記を確認し、Shuuに今日の優先事項を3行以内で報告してください。"
