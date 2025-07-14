bindkey '^v' edit-command-line              # 将 Ctrl+v 绑定为 edit-command-line
bindkey -v                                  # 启用 vi 模式

# bindkey -M vicmd "i" vi-insert
# bindkey -M vicmd "K" vi-insert-bol
# bindkey -M vicmd "b" vi-backward-char
# bindkey -M vicmd "w" vi-forward-char
# bindkey -M vicmd "0" vi-beginning-of-line
# bindkey -M vicmd "A" vi-end-of-line
# bindkey -M vicmd "K" down-line-or-history
# bindkey -M vicmd "u" up-line-or-history
# bindkey -M vicmd "u" undo
# #bindkey -M vicmd "-" vi-rev-repeat-search
# bindkey -M vicmd "=" vi-repeat-search
# bindkey -M vicmd "h" vi-forward-word-end

function zle-keymap-select {
    # $KEYMAP 是当前键盘的映射模式
	if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
		echo -ne '\e[2 q'                   # 进入 normal 模式时, 方块
	elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || [[ ${KEYMAP} = '' ]] || [[ $1 = 'beam' ]]; then
		echo -ne '\e[4 q'                   # 处于 insert 模式时, 下划线
  fi
}

zle -N zle-keymap-select                    # 将函数注册为钩子函数, 每次在 insert/normal 切换时执行 zle-keymap-select

# Use beam shape cursor on startup.
echo -ne '\e[4 q'

# Use beam shape cursor for each new prompt.
preexec() {
	echo -ne '\e[4 q'
}

_fix_cursor() {
	echo -ne '\e[4 q'
}
precmd_functions+=(_fix_cursor)

KEYTIMEOUT=1

