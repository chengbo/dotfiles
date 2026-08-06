This is my personal dotfiles, managed with [chezmoi](https://www.chezmoi.io/).

## Setup on a new machine

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply chengbo/dotfiles
```

## Usage

```sh
chezmoi edit ~/.zshrc   # edit a managed file (edits the source, not the target)
chezmoi diff            # preview what would change
chezmoi apply           # apply the source state to the home directory
chezmoi cd              # cd into the source directory to commit/push changes
```
