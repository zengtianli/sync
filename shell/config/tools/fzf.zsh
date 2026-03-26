# FZF 配置文件 - 集中管理fzf相关设置和功能
# FZF 基本设置
export FZF_DEFAULT_OPTS='--bind=ctrl-f:top,change:top --bind ctrl-j:down,ctrl-k:up --preview "highlight -O ansi -l {} 2> /dev/null || cat {} 2> /dev/null | head -500" --preview-window=right:60%'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_COMPLETION_TRIGGER='\'
export FZF_TMUX=1
export FZF_TMUX_HEIGHT='80%'
export fzf_preview_cmd='f() { MIMETYPE=$(file --mime-type -b "$1"); if [[ $MIMETYPE == binary/* || $MIMETYPE == application/octet-stream ]]; then echo "$1 is a binary file"; else if command -v bat &>/dev/null; then bat --color=always "$1"; elif command -v ccat &>/dev/null; then ccat --color=always "$1"; elif command -v highlight &>/dev/null; then highlight -O ansi -l "$1"; else cat "$1"; fi; fi } && f {}'
# FZF 路径设置
_fzf_fpath=${0:h}/fzf
fpath+=$_fzf_fpath
autoload -U $_fzf_fpath/*(.:t)
unset _fzf_fpath
# FZF 提示刷新函数
fzf-redraw-prompt() {
	local precmd
	for precmd in $precmd_functions; do
		$precmd
	done
	zle reset-prompt
}
zle -N fzf-redraw-prompt
zle -N fzf-find-widget
bindkey '^p' fzf-find-widget
# 增强版的fzf-find-widget - 找到文件后自动用nvim打开
fzf-find-and-edit-widget() {
    local file=$(fd --type f | fzf)
    if [[ -n "$file" ]]; then
        BUFFER="nvim '$file'"
        zle accept-line
    fi
    zle reset-prompt
}
zle -N fzf-find-and-edit-widget
# FZF 目录切换小部件
fzf-cd-widget() {
	local tokens=(${(z)LBUFFER})
	if (( $#tokens <= 1 )); then
		zle fzf-find-widget 'only_dir'
		if [[ -d $LBUFFER ]]; then
			cd $LBUFFER
			local ret=$?
			LBUFFER=
			zle fzf-redraw-prompt
			return $ret
		fi
	fi
}
zle -N fzf-cd-widget
bindkey '^t' fzf-cd-widget
# FZF 历史记录小部件
fzf-history-widget() {
	local num=$(fhistory $LBUFFER)
	local ret=$?
	if [[ -n $num ]]; then
		zle vi-fetch-history -n $num
	fi
	zle reset-prompt
	return $ret
}
zle -N fzf-history-widget
bindkey '^R' fzf-history-widget
# FZF 文件内容搜索函数
fif() {
  if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
  local file=$(rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}")
  if [[ -n "$file" ]]; then
    nvim "$file"
  fi
}
# 增强版文件内搜索小部件 - 找到文件后自动用nvim打开
find-in-file-and-edit() {
	local selected=$(grep --line-buffered --color=never -r "" * | fzf)
	if [[ -n "$selected" ]]; then
		local file=$(echo "$selected" | awk -F ":" '{print $1}')
		if [[ -n "$file" ]]; then
			BUFFER="nvim '$file'"
			zle accept-line
		fi
	fi
	zle reset-prompt
}
zle -N find-in-file-and-edit
bindkey '^f' find-in-file-and-edit
bindkey '^P' fzf-find-and-edit-widget
