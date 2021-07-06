#!/bin/bash

LOCAL_PLUGINS=(tecton-dev tectonctl tecton-sdk env creds meme)

LOCAL_PLUGIN_LOCATION="$HOME"/local_bin
for plugin in $LOCAL_PLUGINS; do
	source "$LOCAL_PLUGIN_LOCATION/$plugin".sh
done

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

alias nvim='~/nvim-osx64/bin/nvim'
