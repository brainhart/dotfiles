# Brian's Dotfiles

Managed with chezmoi: https://github.com/twpayne/chezmoi

## Needed installs

Homebrew Formulae:
- antibody
- bash (mac recommended to brew install for updates)
- bat
- chezmoi
- coreutils
- curl
- diff-so-fancy (vendored in dotfiles)
- diffstat
- git-wip (vendored in dotfiles)
- exa
- fd
- fswatch
- fzf
- git
- go
- grep
- htop
- jq
- kubectl
- sed (mac recommended to install gnu-sed)
- moreutils
- neovim
- nvm
- pyenv
- pyenv-virtualenv
- ripgrep
- rust
- shellcheck
- shfmt
- terraform (TBD: tfenv?) [currently built from source, but forget exactly why]
- tmux
- tree
- wget
- zsh

Homebrew Casks:
- alfred
- 1password
- 1password-cli
- aws-vault
- font-fira-code
- go2shell
- muzzle
- rectangle

Cargo:
- ccase

Web (desire manual install):
- Chrome
- Slack
- Spotify
- Docker

Work:
- aws-vault
- grpcurl
- JDK
- postgresql@11
- skaffold
- tunnelblick
- vegeta

## TODO
- idempotent install of majority of packages on MacOS
- codegrep function (use ccase to search across snake_case, PascalCase, CamelCase, etc)
- Linux installs?
- Better k8s functions and/or use tool like k9s
