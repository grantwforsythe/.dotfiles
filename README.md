## Installation 
1. `git clone` into desired directory
2. Ensure `tmux`, `vim`, and `zsh` are installed
3. Run `.\install.sh` passing in the path to the directory as an argument

## Adding New Dotfiles
When adding a new dotfile, append the filename (**excluding the "."**) to the `FILES` variable in `install.sh` to symlink it.
