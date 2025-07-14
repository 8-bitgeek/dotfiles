# autojump support (macOS + Linux)
if [[ -s "$(brew --prefix autojump 2>/dev/null)/etc/profile.d/autojump.sh" ]]; then
  source "$(brew --prefix autojump)/etc/profile.d/autojump.sh"
elif [[ -s /usr/share/autojump/autojump.sh ]]; then
  source /usr/share/autojump/autojump.sh
fi

