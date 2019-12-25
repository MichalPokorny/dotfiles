# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin directories
PATH="$HOME/bin:$HOME/.local/bin:$HOME/bin/private-scripts:$PATH"

# Ruby
# PATH="$(ruby -rubygems -e 'puts Gem.user_dir')/bin:$PATH"

# Haskell
PATH="$HOME/.cabal/bin:$PATH"

# Go
export GOPATH=$HOME/repos/go
PATH="$GOPATH/bin:$PATH"
EDITOR=`which vim`

# Android Studio
PATH="/opt/android-studio/bin:$PATH"
