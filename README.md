This is my personal dotfiles. It utilizes [GNU Stow](https://www.gnu.org/software/stow/) to keep all configuration files under this repository.

Use package manager to install stow first. For example on MacOS, use

`brew install stow`

Then I am able to install vim settings by

`stow vim`

or install tumx

`stow tmux`

To uninstall vim, use

`stow -D vim`
