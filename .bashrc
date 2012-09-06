#
# ~/.bashrc
#

. /etc/profile

if [ -f /usr/share/bash-completion/bash_completion ] && ! shopt -oq posix; then
    . /usr/share/bash-completion/bash_completion
fi

if [ -f /home/prvak/bin/git-prompt.sh ]; then
	. /home/prvak/bin/git-prompt.sh
fi

export PATH=$PATH.":/home/prvak/bin:/usr/lib/surfraw:/opt/naturaldocs"
export EDITOR=`which vim`

if [[ $- != *i* ]]; then
	return	# shell je neinteraktivni
fi

my_git_ps1 ()
{
	if [ -z "$(git symbolic-ref HEAD 2> /dev/null)" ]; then
		return
	fi
	local GITROOT="$(git rev-parse --show-toplevel)"
	if [ "$GITROOT" != "/home/prvak" ]; then
		__git_ps1 "\033[00m%s \033[01;34m"
	fi
}

PROMPT_COLOR='\[\033[01;32m\]'

if [[ $EUID -eq 0 ]]; then
	PROMPT_COLOR='\[\033[01;31m\]'
fi

# For servers:
#PS1=$PROMPT_COLOR'\u@\h \w \[\033[01;34m\]$(my_git_ps1)\$\[\033[00m\] '

PS1=$PROMPT_COLOR'\w \[\033[01;34m\]$(my_git_ps1)\$\[\033[00m\] '

#fortune
## fortune cs
#LINES=`cat /home/prvak/NOTES | wc -l`
#LINE=`expr $RANDOM % $LINES + 1`
#head -$LINE /home/prvak/NOTES | tail -1

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

# Kompletuj prikazy po techto vecech...
complete -cf sudo
complete -cf man
alias lingot="fmit"

shopt -s histappend

# Vypsani adresare -> cd tam.
# Echuje, kam se CDckuje... :(
shopt -s autocd

complete -o nospace -F _cd j
export AUTOJUMP_IGNORE_CASE=1
