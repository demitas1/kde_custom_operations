#!/bin/bash

# 色の定義
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# スクリプト関連の定義
SCRIPT_NAME="tilelefttwo"
INSTALL_DIR="$HOME/.local/share/kwin/scripts/$SCRIPT_NAME"
SOURCE_DIR="./scripts/$SCRIPT_NAME"

echo -e "${YELLOW}KWinスクリプト「$SCRIPT_NAME」のインストールを開始します...${NC}"

# ソースディレクトリの存在確認
if [ ! -d "$SOURCE_DIR" ]; then
    echo -e "${RED}エラー: ソースディレクトリ ($SOURCE_DIR) が見つかりません${NC}"
    exit 1
fi

# 必要なファイルの存在確認
if [ ! -f "$SOURCE_DIR/metadata.desktop" ] || [ ! -f "$SOURCE_DIR/contents/code/main.js" ]; then
    echo -e "${RED}エラー: 必要なソースファイルが見つかりません${NC}"
    echo "以下のファイルが必要です:"
    echo "- $SOURCE_DIR/metadata.desktop"
    echo "- $SOURCE_DIR/contents/code/main.js"
    exit 1
fi

# インストールディレクトリの作成
echo "ディレクトリを作成中..."
mkdir -p "$INSTALL_DIR/contents/code"

# ファイルのコピー
echo "ファイルをコピー中..."
cp "$SOURCE_DIR/metadata.desktop" "$INSTALL_DIR/"
cp "$SOURCE_DIR/contents/code/main.js" "$INSTALL_DIR/contents/code/"

# パーミッションの設定
chmod 755 "$INSTALL_DIR"
chmod 644 "$INSTALL_DIR/metadata.desktop"
chmod 644 "$INSTALL_DIR/contents/code/main.js"

if [ $? -eq 0 ]; then
    echo -e "${GREEN}インストールが完了しました${NC}"
    echo "インストール先: $INSTALL_DIR"
    echo -e "${YELLOW}注意: KWinの設定を再読み込みするために、以下のいずれかの操作を行ってください:${NC}"
    echo "1. システム設定 > ウィンドウの管理 > KWinスクリプト で一度無効化してから再度有効化"
    echo "2. 以下のコマンドを実行: kwin --replace & disown"
else
    echo -e "${RED}インストール中にエラーが発生しました${NC}"
    exit 1
fi
