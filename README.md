# 哲鉄日々 — 個人会社システム

> 哲学の力で、ひとりひとりが自分の人生を主体的に設計できる社会を作る

## 概要

有田修（Shuu）が「自分を経営する会社」として、Claude Codeのエージェント機能で各部署をAIとして動かすシステムです。

## 会社構造

```
社長: Shuu（有田修）
└── CEO: Claude
    ├── 秘書        ← タスク管理・スケジュール・アイデア整理
    ├── 開発部      ← アプリ開発・YouTube台本・哲学教材制作
    ├── PM          ← 進捗管理・スプリント
    ├── リサーチ    ← 市場調査・哲学リサーチ
    ├── マーケティング ← SNS下書き・コンテンツ企画
    └── 経営部      ← 事業戦略・財務管理
```

## 使い方

### 通常セッション（CEOとして対話）
```bash
cd /path/to/this-repo
claude
```
セッション開始時に今日のタスクと直近アイデアがブリーフィングされます。

### 部署に直接指示する
```bash
./scripts/delegate.sh 秘書 "明日の午前10時に哲学イベント準備を1時間入れて"
./scripts/delegate.sh 開発部 "青春と偏見の第1回YouTube台本を作って"
./scripts/delegate.sh 経営部 "今月の収支をまとめて"
```

### アイデアをすばやく保存する（セッション不要）
```bash
./scripts/capture-idea.sh "B2B向けワークショップ" "企業新入社員研修への哲学組み込み"
```

## 事業内容

**哲鉄日々（てつてつひび）**
- B2C: 個人の人生設計AI、ミッション策定AI
- B2B: 企業カルチャー・ミッション/ビジョン/バリューの言語化コンサル

**その他**
- YouTube: 青春と偏見（Osumi-kunと共同）
- 哲学イベント（丸グループビジコン2位入賞）

## セットアップ

### 1. 環境変数の設定（MCP連携が必要な場合）
```bash
cp .env.example .env
# .env を開いて各APIキーを設定する
```

### 2. MCPサーバーの追加（必要なものだけ）
```bash
# Notion
claude mcp add notion -- npx -y @notionhq/notion-mcp-server

# Google Calendar
claude mcp add google-calendar -- npx -y @modelcontextprotocol/server-google-calendar

# Obsidian（Obsidian Local REST APIプラグインが必要）
claude mcp add obsidian -- npx -y obsidian-mcp

# GitHub
claude mcp add github -- npx -y @modelcontextprotocol/server-github
```

## ディレクトリ構造

```
/
├── CLAUDE.md              ← 会社コンテキスト・CEO設定（最重要）
├── .claude/
│   ├── settings.json      ← MCP設定・SessionStartフック
│   └── agents.json        ← 部署エージェント定義
├── 秘書/
│   ├── CLAUDE.md
│   ├── tasks/             ← 日付別タスクファイル
│   ├── ideas/             ← アイデアキャプチャ
│   └── daily-log/         ← 日次ログ
├── 開発/
│   ├── CLAUDE.md
│   ├── app/               ← アプリソースコード
│   ├── content/
│   │   ├── youtube/       ← YouTube台本
│   │   ├── articles/      ← 哲学記事・教材
│   │   └── prompts/       ← AIプロンプト設計
│   └── docs/
├── PM/
│   ├── CLAUDE.md
│   └── progress/          ← スプリントファイル
├── リサーチ/
│   ├── CLAUDE.md
│   └── reports/
├── マーケティング/
│   ├── CLAUDE.md
│   └── sns/               ← SNS投稿下書き
├── 経営部/
│   ├── CLAUDE.md
│   ├── finance/           ← 月次財務記録
│   └── strategy/          ← OKR・戦略文書
├── scripts/
│   ├── morning-briefing.sh
│   ├── delegate.sh
│   └── capture-idea.sh
└── .env.example           ← 環境変数テンプレート
```
