bindkey -v
# 历史搜索键绑定
zmodload -F zsh/terminfo +p:terminfo
# 自定义评估函数和工具函数
zle_eval() { echo -en "\e[2K\r"; eval "$@"; zle redisplay }
# 打开lazygit的快捷键
openlazygit() { zle_eval lazygit }
zle -N openlazygit
bindkey "^G" openlazygit
# 打开Finder的快捷键
openfinder() { zle_eval "open -a Finder ./" }
zle -N openfinder
bindkey "^O" openfinder

tagsearch() {
  local initial_tags="${1:-}"
  fzf --disabled --query "$initial_tags" \
      --bind "change:reload:sleep 0.1; [ -n {q} ] && mdfind \"\$(echo {q} | tr ',' '\n' | sed \"s/^/kMDItemUserTags == '/\" | sed \"s/$/'/\" | paste -sd ' && ' -)\" || echo 'Enter tags separated by commas'" \
      --preview 'ls -l {}' --preview-window 'right:60%' \
      --header 'Enter tags separated by commas. Press CTRL-O to open file, ENTER to select.' \
      --bind 'ctrl-o:execute(open {})' --multi
}
