open-file() {
    local file_cmd preview_cmd file
    local current_input="$BUFFER"

    # 判断是否安装 fd，否则 fallback 到 find
    if command -v fd &>/dev/null; then
        file_cmd="fd --type f --exclude .git --exclude node_modules --exclude dist ."
    else
        file_cmd="find . -type d \( -name .git -o -name node_modules -o -name dist \) -prune -o -type f -print 2>/dev/null"
    fi

    # 判断是否安装 bat，否则 fallback 到 cat
    if command -v bat &>/dev/null; then
        preview_cmd='bat --style=numbers --color=always {}'
    elif command -v batcat &>/dev/null; then
        preview_cmd='batcat --style=numbers --color=always {}'
    else
        preview_cmd='cat {}'
    fi

    # 执行 fzf 搜索
    file=$(eval "$file_cmd" | fzf --height 40% --reverse --preview "$preview_cmd" --query="")

    # 修复 ESC 退出时卡住的问题
    zle -I
    zle reset-prompt

    [[ -z $file ]] && return 0

    if [[ -z "$current_input" ]]; then
          # 命令行是空的，直接执行 nvim <file>
          zle clean-screen
          nvim $file
          zle reset-prompt
    else
          # 命令行有内容，追加文件路径到末尾
          BUFFER="$current_input$file"
          CURSOR=$#BUFFER
          zle reset-prompt
    fi

    # 刷新 zsh 提示符状态, 如果不添加的话退出 vim 会卡住
    zle reset-prompt
}

