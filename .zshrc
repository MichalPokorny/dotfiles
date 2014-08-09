#
# ~/.zshrc
#
. /etc/profile

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="blinks" # works with Solarized
# "evan" ## very minimalistic

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to disable command auto-correction.
DISABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
#
# gitfast
# git: gc, gca, gs, ...
# plugins=(rails git sudo rake gpg-agent gem colored-man)
plugins=(git gpg-agent gem colored-man)

source $ZSH/oh-my-zsh.sh

# User configuration
#
# ============================================================
#
# The following lines were added by compinstall

# Nechci completion automaticky kdyz je to ambiguous
unsetopt menu_complete
unsetopt auto_menu

zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list ''

#autoload -Uz compinit
#compinit

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

setopt autocd

# vi mode
#bindkey -v

# emacs mode
bindkey -e

# End of lines configured by zsh-newuser-install
# --------------------------
# My modifications

alias gs='git status' # I don't want GhostScript.
alias M='mutt'
alias Am='alsamixer'
alias Wc='wicd-curses'
alias diff='colordiff'
alias phpc='php -a'
alias notes='vim ~/NOTES'

# Record keystrokes
# alias vim='vim -w ~/.vim-keylog "$@"'

alias suspend='systemctl suspend'

if (which sux &> /dev/null); then
	alias su='sux'
fi

function set_custom_prompt {
	if [ $UID -eq 0 ]; then
		#DIR_COLOR="%F{160}"; # dark red
		#PROMPT_COLOR="%F{001}"; # red
		THE_PROMPT="#";
	else
		#DIR_COLOR="%F{155}"; # medium green
		#PROMPT_COLOR="%F{033}"; # medium blue
		THE_PROMPT="λ"; # lambda
		# THE_PROMPT="»"; # dvojsipka
		# THE_PROMPT="→"; # sipka
	fi

	#PROMPT='$DIR_COLOR%~ $PROMPT_COLOR$THE_PROMPT %k'
	PROMPT='%~ $THE_PROMPT '
	#RPROMPT='%p $(git_prompt_info) %F{247}%*%k' # light gray
	RPROMPT='$(git_prompt_info) %*'

	#### ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE="(behind)"
	#### ZSH_THEME_GIT_PROMPT_BEHIND_AHEAD="(ahead)"
	#### ZSH_THEME_GIT_PROMPT_BEHIND_DIVERGED="(diverged)"
	#### ZSH_THEME_GIT_PROMPT_AHEAD="(ahead-commits)"
	#### # ZSH_THEME_GIT_PROMPT_PREFIX="%F{252}" # light gray
	#### ZSH_THEME_GIT_PROMPT_PREFIX=""
	#### ZSH_THEME_GIT_PROMPT_SUFFIX=""
	#### ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}±%{$reset_color%}"
	#### ZSH_THEME_GIT_PROMPT_CLEAN=""
}

function set_agnoster {
	ZSH_THEME="agnoster" # works with Solarized
	RPROMPT='%*'
	DEFAULT_USER='prvak'
}

#set_custom_prompt
set_agnoster

export PATH="$PATH:/home/prvak/bin:/home/prvak/bin/btckit:/home/prvak/bin/private-scripts:$(ruby -rubygems -e 'puts Gem.user_dir')/bin:$HOME/.cabal/bin:/opt/android-sdk/platform-tools"
export BROWSER="firefox"

ZSH_THEME_TERM_TITLE_IDLE="%n: %~ $"

unsetopt share_history # Don't share command history between zsh's

eval `dircolors ~/.dircolors-solarized/dircolors.ansi-dark`
export MC_SKIN=~/.config/mc/solarized.ini
