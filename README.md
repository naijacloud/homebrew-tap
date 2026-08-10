# homebrew-tap

Homebrew tap for the [NaijaCloud CLI](https://github.com/naijacloud/nc-cli).

## Install

```bash
brew install naijacloud/tap/naijacloud
```

Or tap once, then install by short name:

```bash
brew tap naijacloud/tap
brew install naijacloud
```

Either way the CLI lands on your PATH under **two names**, `naijacloud` and the
shorter `njc`. They are the same executable.

The formula installs a standalone binary that embeds its own runtime, so Node is
not required. Bottles are provided for macOS (arm64 and x86_64) and Linux
(arm64 and x86_64).

## Upgrading

```bash
brew update && brew upgrade naijacloud
```

## Contents

`Formula/naijacloud.rb` is generated from
[`packaging/templates/homebrew/naijacloud.rb`](https://github.com/naijacloud/nc-cli/blob/main/packaging/templates/homebrew/naijacloud.rb)
and committed here by the release workflow in
[naijacloud/nc-cli](https://github.com/naijacloud/nc-cli) on every release, with
the version and the SHA-256 of each published artifact filled in.

**Do not edit the formula here.** The next release overwrites it. Change the
template in `nc-cli` instead.

## Issues

Report problems with the CLI itself at
[naijacloud/nc-cli/issues](https://github.com/naijacloud/nc-cli/issues).
