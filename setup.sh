# デフォルトシェルをfishに設定
#
# もし、出来ない場合は
# sudo vim /etc/shells をし
#
# 最後の行に
# /usr/local/bin/fish を追加
#
chsh -s /usr/local/bin/fish

# fisherman install
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher

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

# tmux-powerline
cd
git clone git://github.com/erikw/tmux-powerline.git

# dot
cd
git clone https://github.com/ssh0/dot ~/.dot
set -U DOT_REPO https://github.com/CASIXx1/dotfiles.git
set -U DOT_DIR ~/dotfiles
set -U DOT_SCR ~/.dot

# fisherman
fisher add re3turn/fish-dot
