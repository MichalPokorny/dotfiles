# ~/.zshrc
. /etc/profile

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="blinks" # works with Solarized
# "evan" ## very minimalistic

# Uncomment to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Disable command auto-correction.
DISABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Disable marking untracked files under VCS as dirty.
# This makes repository status check for large repositories much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Change the command execution time stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

# gitfast
# git: gc, gca, gs, ...
# interesting plugins: 'z'
plugins=(git gpg-agent gem web-search colored-man)

source $ZSH/oh-my-zsh.sh

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

alias gs='git status' # I don't want GhostScript.
alias M='mutt'
alias Am='alsamixer'
alias Wc='wicd-curses'
alias diff='colordiff'
alias phpc='php -a'
alias notes='vim ~/NOTES'
alias perlc='perl -d -e 1'

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
		# » (dvojsipka), → (sipka)
	fi

	#PROMPT='$DIR_COLOR%~ $PROMPT_COLOR$THE_PROMPT %k'
	PROMPT='%~ $THE_PROMPT '
	RPROMPT='$(git_prompt_info) %*'
}

# Sets the 'agnoster' theme. It works with Solarized.
# Unfortunately, it assumes custom patched fonts.
function set_agnoster {
	ZSH_THEME="agnoster" # works with Solarized
	RPROMPT='%*'
	DEFAULT_USER='prvak'
}

# set_agnoster
set_custom_prompt

export GOBIN=~/bin/gobin
export PATH="$PATH:/home/prvak/bin:/home/prvak/bin/private-scripts:$(ruby -rubygems -e 'puts Gem.user_dir')/bin:$HOME/.cabal/bin:/opt/android-sdk/platform-tools:$GOBIN"

ZSH_THEME_TERM_TITLE_IDLE="%n: %~ $"

unsetopt share_history # Don't share command history between zsh's

eval `dircolors ~/.dircolors-solarized/dircolors.ansi-dark`
export MC_SKIN=~/.config/mc/solarized.ini
