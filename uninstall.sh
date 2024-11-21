#!/bin/bash

# 色の定義
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# アンインストール関数
uninstall_kwin_script() {
    local script_name="$1"
    local install_dir="$HOME/.local/share/kwin/scripts/$script_name"
    
    echo -e "${YELLOW}KWinスクリプト「$script_name」のアンインストールを開始します...${NC}"
    
    # インストールディレクトリの存在確認
    if [ ! -d "$install_dir" ]; then
        echo -e "${YELLOW}スクリプト「$script_name」はすでにアンインストールされています${NC}"
        return 0
    fi
    
    # ファイルの削除
    echo "ファイルを削除中..."
    rm -rf "$install_dir"
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}スクリプト「$script_name」のアンインストールが完了しました${NC}"
        return 0
    else
        echo -e "${RED}スクリプト「$script_name」のアンインストール中にエラーが発生しました${NC}"
        return 1
    fi
}

# アンインストールするスクリプトのリスト
SCRIPTS=("tile_left_two_thirds" "tile_right_one_thirds")
UNINSTALL_ERROR=0

# 各スクリプトをアンインストール
for script in "${SCRIPTS[@]}"; do
    uninstall_kwin_script "$script"
    if [ $? -ne 0 ]; then
        UNINSTALL_ERROR=1
    fi
done

# 最終的な結果表示
if [ $UNINSTALL_ERROR -eq 0 ]; then
    echo -e "\n${GREEN}全てのスクリプトのアンインストールが完了しました${NC}"
    echo -e "${YELLOW}注意: KWinの設定を再読み込みするために、以下のコマンドを実行することを推奨します:${NC}"
    echo "kwin --replace & disown"
else
    echo -e "\n${RED}一部のスクリプトのアンインストールに失敗しました${NC}"
    exit 1
fi
