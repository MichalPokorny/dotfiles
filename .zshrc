# The following lines were added by compinstall
zstyle ':completion:*' completer _complete _ignored _approximate
zstyle :compinstall filename '/home/prvak/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob
bindkey -v
# End of lines configured by zsh-newuser-install

export PATH="$PATH:/home/prvak/bin:/usr/lib/surfraw:/opt/naturaldocs:~/.gem/ruby/1.9.1/bin:~/.cabal/bin"
export EDITOR=`which vim`

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git # no svn.
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git*' formats " %b"
setopt prompt_subst

precmd() {
	if [ -z "$(git symbolic-ref HEAD 2> /dev/null)" ]; then
		return
	fi
	local GITROOT="$(git rev-parse --show-toplevel)"
	# TODO: chtel bych, aby se neukazoval git status kazdeho adresare, ve kterem nekdo bydli
	if [ "$GITROOT" != "$HOME" ]; then
		PROMPT='${fg_lgreen}%~${fg_white}${vcs_info_msg_0_}${fg_blue} $ ${fg_white}'
	else
		PROMPT='${fg_lgreen}%~${fg_white}${fg_blue} $ ${fg_white}'
	fi

	vcs_info
}

fg_lgreen=%{$'\e[1;32m'%}
fg_blue=%{$'\e[1;34m'%}
fg_white=%{$'\e[1;37m'%}
# PROMPT='${fg_lgreen}%~${fg_white}${vcs_info_msg_0_}${fg_blue}$ ${fg_white}'

alias Gs='git status'
alias Gd='git diff'
alias Gc='git commit -a'
alias GC='git commit'
alias Gp='git push'
alias Ga='git add'
alias Gco='git checkout'
alias Gcl='git clone'
alias Gb='git branch'
alias GP='git pull'
alias Am='alsamixer'
alias Wc='wicd-curses'
alias diff='colordiff'
alias ls='ls --color=auto'
alias phpc='php -a'
alias su='sux'
alias ..='cd ..'
alias suspend='sudo systemctl suspend'

# Force old GNOME / QT applications to use XFT.
export GDK_USE_XFT=1
export QT_XFT=true
