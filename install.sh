#!/bin/bash

# 色の定義
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# スクリプトのインストール関数
install_kwin_script() {
    local script_name="$1"
    local install_dir="$HOME/.local/share/kwin/scripts/$script_name"
    local source_dir="./scripts/$script_name"

    echo -e "${YELLOW}KWinスクリプト「$script_name」のインストールを開始します...${NC}"

    # ソースディレクトリの存在確認
    if [ ! -d "$source_dir" ]; then
        echo -e "${RED}エラー: ソースディレクトリ ($source_dir) が見つかりません${NC}"
        return 1
    fi

    # 必要なファイルの存在確認
    if [ ! -f "$source_dir/metadata.desktop" ] || [ ! -f "$source_dir/contents/code/main.js" ]; then
        echo -e "${RED}エラー: 必要なソースファイルが見つかりません${NC}"
        echo "以下のファイルが必要です:"
        echo "- $source_dir/metadata.desktop"
        echo "- $source_dir/contents/code/main.js"
        return 1
    fi

    # インストールディレクトリの作成
    echo "ディレクトリを作成中..."
    mkdir -p "$install_dir/contents/code"

    # ファイルのコピー
    echo "ファイルをコピー中..."
    cp "$source_dir/metadata.desktop" "$install_dir/"
    cp "$source_dir/contents/code/main.js" "$install_dir/contents/code/"

    # パーミッションの設定
    chmod 755 "$install_dir"
    chmod 644 "$install_dir/metadata.desktop"
    chmod 644 "$install_dir/contents/code/main.js"

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}「$script_name」のインストールが完了しました${NC}"
        echo "インストール先: $install_dir"
        return 0
    else
        echo -e "${RED}「$script_name」のインストール中にエラーが発生しました${NC}"
        return 1
    fi
}

# インストールするスクリプトのリスト
SCRIPTS=("tile_left_two_thirds" "tile_right_one_thirds")
INSTALL_ERROR=0

# 各スクリプトをインストール
for script in "${SCRIPTS[@]}"; do
    install_kwin_script "$script"
    if [ $? -ne 0 ]; then
        INSTALL_ERROR=1
    fi
done

# 最終的な結果表示
if [ $INSTALL_ERROR -eq 0 ]; then
    echo -e "\n${GREEN}全てのスクリプトのインストールが完了しました${NC}"
    echo -e "${YELLOW}注意: KWinの設定を再読み込みするために、以下のいずれかの操作を行ってください:${NC}"
    echo "1. システム設定 > ウィンドウの管理 > KWinスクリプト で一度無効化してから再度有効化"
    echo "2. 以下のコマンドを実行: kwin --replace & disown"
else
    echo -e "\n${RED}一部のスクリプトのインストールに失敗しました${NC}"
    exit 1
fi
