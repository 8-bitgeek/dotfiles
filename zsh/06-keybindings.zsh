# 默认使用 vi 模式
bindkey -v

# 在 insert 模式中，绑定 Home/End 键
bindkey -M viins '^[[H' beginning-of-line
bindkey -M viins '^[OH' beginning-of-line  # 有的终端发这个序列
bindkey -M viins '^[[F' end-of-line
bindkey -M viins '^[OF' end-of-line

# 在 normal 模式中, 绑定 Home/End 键
bindkey -M vicmd '^[[H' beginning-of-line
bindkey -M vicmd '^[OH' beginning-of-line
bindkey -M vicmd '^[[F' end-of-line
bindkey -M vicmd '^[OF' end-of-line

# 上下方向键支持 substring 搜索
zmodload -F zsh/terminfo +p:terminfo
for key ('^[[A' '^P' ${terminfo[kcuu1]}) bindkey ${key} history-substring-search-up
for key ('^[[B' '^N' ${terminfo[kcud1]}) bindkey ${key} history-substring-search-down
for key ('k') bindkey -M vicmd ${key} history-substring-search-up
for key ('j') bindkey -M vicmd ${key} history-substring-search-down
unset key

zle -N open-file
bindkey '^o' open-file
