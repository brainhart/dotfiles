# Brian's Dotfiles

Managed with chezmoi: https://github.com/twpayne/chezmoi

## CLI ownership

Apple Silicon CLI binaries are managed primarily as checksum-pinned DotSlash
files in `bin/`. The source catalog is
`dot_config/dotslash/tools.json`; regenerate every tool or selected tools with:

```sh
update-dotslash
update-dotslash jq rg chezmoi
```

The updater queries official GitHub releases, requires exactly one matching
artifact, downloads it, computes a BLAKE3 digest, and rewrites the corresponding
chezmoi `bin/executable_*` source file. Review the diff, run the manifest, and
commit both the catalog and generated files together.

Aqua remains a compatibility layer only for distributions that are a poor fit
for DotSlash: Terraform, Helm, Go, aws-vault, the ECR credential helper, and
Tala. Aqua itself is bootstrapped by DotSlash. Eza, AWS CLI, and Tailscale use
Homebrew because their current macOS packaging is not suitable for DotSlash or
the Aqua registry recipe.

## Needed installs

Homebrew Formulae / Casks / Taps:
- Brewfile

Cargo:
- ccase

Web (desire manual install):
- Chrome
- Slack
- Spotify

Work:
- aws-vault
- grpcurl
- JDK
- postgresql@11
- skaffold
- tunnelblick
- vegeta

## TODO
- Linux installs?
