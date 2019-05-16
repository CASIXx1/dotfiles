# neovim setting
#
# 出来ない場合は
# sudo installer -pkg /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_10.14.pkg -target /
#
xcode-select --install
brew update && brew upgrade pyenv
pyenv install 3.7.3
pyenv global 3.7.3
pip3 install --upgrade neovim

mkdir -p ~/.config/nvim
ln -sf ~/.vim ~/.config/nvim/
ln -sf ~/.vimrc ~/.config/nvim/init.vim
