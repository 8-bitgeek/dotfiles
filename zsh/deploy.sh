#!/bin/bash


set -e

DOTFILES_DIR="$HOME/.config/dotfiles/zsh"
ZSHRC_TARGET="$HOME/.zshrc"
ZIMRC_TARGET="$HOME/.zimrc"
ZSH_CONFIG_DIR="$HOME/.config/zsh"

backup_if_exists() {
    local file="$1"
    if [ -e "$file" ] && [ ! -L "$file" ]; then
        cp "$file" "$file.bak.$(date +%Y%m%d%H%M%S)"
        echo "✅ Backed up $file → $file.bak"
    fi
}

echo "▶️ Deploying zsh dotfiles from $DOTFILES_DIR"

# Step 1: 创建 config 目录
mkdir -p "$ZSH_CONFIG_DIR"

# Step 2: 安装 zimfw（如果没装）
if [ ! -f "$HOME/.zim/zimfw.zsh" ]; then
    echo "📦 Installing zimfw..."
    curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
else
    echo "✅ zimfw 已安装"
fi

# step 3: 备份老文件
backup_if_exists "$ZSHRC_TARGET"
backup_if_exists "$ZIMRC_TARGET"

# Step 4: 链接 .zshrc 和 .zimrc
ln -sf "$DOTFILES_DIR/zshrc" "$ZSHRC_TARGET"
ln -sf "$DOTFILES_DIR/zimrc" "$ZIMRC_TARGET"
echo "✅ Linked zshrc & zimrc"

# Step 5: 链接 *.zsh 文件
for file in "$DOTFILES_DIR"/*.zsh; do
    filename=$(basename "$file")
    ln -sf "$file" "$ZSH_CONFIG_DIR/$filename"
    echo "✅ Linked $filename → $ZSH_CONFIG_DIR/"
done

echo "✅ 部署完成。你可以执行："
echo "   source ~/.zshrc"

