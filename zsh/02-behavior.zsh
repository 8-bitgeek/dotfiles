# 去重历史命令
setopt HIST_IGNORE_ALL_DUPS

# 移除路径分隔符，使跳词更合理
WORDCHARS=${WORDCHARS//[\/]}

# 关闭 autosuggestions 插件的自动按键绑定机制, 防止自己配置的被覆盖
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
# main: 基础命令语法高亮, brackets: 括号匹配高亮
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
