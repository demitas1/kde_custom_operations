#!/bin/bash

# 色の定義
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# スクリプト関連の定義
SCRIPT_NAME="tilelefttwo"
INSTALL_DIR="$HOME/.local/share/kwin/scripts/$SCRIPT_NAME"

echo -e "${YELLOW}KWinスクリプト「$SCRIPT_NAME」のアンインストールを開始します...${NC}"

# インストールディレクトリの存在確認
if [ ! -d "$INSTALL_DIR" ]; then
    echo -e "${YELLOW}スクリプトはすでにアンインストールされています${NC}"
    exit 0
fi

# ファイルの削除
echo "ファイルを削除中..."
rm -rf "$INSTALL_DIR"

if [ $? -eq 0 ]; then
    echo -e "${GREEN}アンインストールが完了しました${NC}"
    echo -e "${YELLOW}注意: KWinの設定を再読み込みするために、以下のコマンドを実行することを推奨します:${NC}"
    echo "kwin --replace & disown"
else
    echo -e "${RED}アンインストール中にエラーが発生しました${NC}"
    exit 1
fi
