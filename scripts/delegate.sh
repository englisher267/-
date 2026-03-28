#!/bin/bash
# 部署エージェントを直接起動するスクリプト
# 使用法: ./scripts/delegate.sh <部署名> "<指示>"
# 例:     ./scripts/delegate.sh 秘書 "明日の午前10時にイベント準備を1時間入れて"
#         ./scripts/delegate.sh 開発部 "青春と偏見の第1回YouTube台本を作って"
#         ./scripts/delegate.sh 経営部 "今月の支出をまとめて"

DEPT=$1
INSTRUCTION=$2
REPO_ROOT="/home/user/-"

# 使用可能な部署リスト
DEPTS=("秘書" "開発部" "PM" "リサーチ" "マーケティング" "経営部")

if [ -z "$DEPT" ] || [ -z "$INSTRUCTION" ]; then
  echo "使用法: $0 <部署名> \"<指示>\""
  echo ""
  echo "利用可能な部署:"
  for d in "${DEPTS[@]}"; do
    echo "  - $d"
  done
  exit 1
fi

DEPT_DIR="$REPO_ROOT/$DEPT"

if [ ! -d "$DEPT_DIR" ]; then
  echo "エラー: 部署ディレクトリが見つかりません: $DEPT_DIR"
  echo ""
  echo "利用可能な部署:"
  for d in "${DEPTS[@]}"; do
    echo "  - $d"
  done
  exit 1
fi

# .envファイルが存在する場合は環境変数を読み込む
if [ -f "$REPO_ROOT/.env" ]; then
  set -a
  source "$REPO_ROOT/.env"
  set +a
fi

echo "=== 哲鉄日々 部署エージェント起動 ==="
echo "部署: $DEPT"
echo "指示: $INSTRUCTION"
echo "=================================="
echo ""

# 部署ディレクトリをコンテキストに追加してClaudeを起動
claude --print \
  --add-dir "$DEPT_DIR" \
  -p "あなたは 哲鉄日々 の${DEPT}エージェントです。$DEPT_DIR/CLAUDE.md を読み込んで、その指示に従って以下を実行してください: $INSTRUCTION"
