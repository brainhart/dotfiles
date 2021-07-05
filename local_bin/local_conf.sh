#!/bin/bash

LOCAL_PLUGINS=(tecton-dev tectonctl tecton-sdk env creds meme)

DOTFILES="$HOME"/dotfiles
for plugin in $LOCAL_PLUGINS; do
	source "$DOTFILES"/shell/local_bin/"$plugin".sh
done

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

alias nvim='~/nvim-osx64/bin/nvim'
