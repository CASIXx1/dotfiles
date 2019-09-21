# Setting

- default設定をする
  - sh .macos
- dotfilesをクローンする
  - `git clone https://github.com/CASIXx1/dotfiles.git`
- brew install
  - `sh brew_install.sh`
- fish setup
- dot setup
  - others setup
  - fisher
    - `cp ./.config/fish/fishfile ~/.config/fish/fishfile`
    - `cp ./.config/fish/config.fish ~/.config/fish/config.fish`
    - `exec fish`
    - `dot update`
- neovim setup
  - `sh ./setup/neovim.sh`
  - `nvim .vim/.vimrc.dein_load`
    - `if &runtimepath !~# '/dein.vim` を一旦削除して、nvim再起動
  - nvim上で, `:call dein#update()`
- nerdfont setup
  - `sh ./setup/nerd-fonts-install.sh`
  - iterm2でfontを設定
    - https://qiita.com/sizukutamago/items/2ba906ab3fa404eac02d#_reference-163929b0cc001a56c9b0
