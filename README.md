This is my personal dotfiles, managed with [chezmoi](https://www.chezmoi.io/).

## Setup on a new machine

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply --source ~/dotfiles chengbo/dotfiles
```

`--source ~/dotfiles` makes chezmoi clone the repo straight into `~/dotfiles`, so that's
the one and only clone on the machine. Don't separately `git clone` this repo elsewhere —
a second clone can drift out of sync with the one chezmoi actually manages.

## Usage

```sh
chezmoi edit ~/.zshrc   # edit a managed file (edits the source, not the target)
chezmoi diff            # preview what would change
chezmoi apply           # apply the source state to the home directory
chezmoi update          # pull the latest changes from the repo and apply them
chezmoi cd              # cd into the source directory to commit/push changes
```
