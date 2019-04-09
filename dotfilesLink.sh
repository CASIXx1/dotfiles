#!/bin/sh

# brew
ln -sf ~/dotfiles/Brewfile ~/Brewfile

# vim
ln -sf ~/dotfiles/.vim/rc/dein.toml ~/.vim/rc/dein.toml
ln -sf ~/dotfiles/.vim/rc/dein_lazy.toml ~/.vim/rc/dein_lazy.toml
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.vimrc.basic ~/.vimrc.basic
ln -sf ~/dotfiles/.vimrc.dein_load ~/.vimrc.dein_load
ln -sf ~/dotfiles/.vimrc.nerdtree ~/.vimrc.nerdtree

# neovim
ln -sf ~/.vim ~/.config/nvim/
ln -sf ~/.vimrc ~/.config/nvim/init.vim

ln -sf ~/dotfiles/colors ~/.vim
ln -sf ~/dotfiles/ftdetect ~/.vim
ln -sf ~/dotfiles/indent ~/.vim
ln -sf ~/dotfiles/.bash_profile ~/.bash_profile
ln -sf ~/dotfiles/.wgetrc ~/.wgetrc
ln -sf ~/dotfiles/Brewfile ~/Brewfile

# fish
ln -sf ~/dotfiles/.config/fish/config.fish ~/.config/fish/config.fish
ln -sf ~/dotfiles/.config/fish/functions/git-sync.fish ~/.config/fish/functions/git-sync.fish
ln -sf ~/dotfiles/.config/fish/functions/peco_select_ghq_repository.fish ~/.config/fish/functions/peco_select_ghq_repository.fish
ln -sf ~/dotfiles/.config/fish/functions/peco_select_history.fish ~/.config/fish/functions/peco_select_history.fish

# tig
ln -sf ~/dotfiles/.tigrc ~/.tigrc

# tmux
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf

# pry
ln -sf ~/dotfiles/.pryrc ~/.pryrc

# karabiner
ln -sf ~/dotfiles/.config/karabiner/karabiner.json ~/.config/karabiner/karabiner.json
