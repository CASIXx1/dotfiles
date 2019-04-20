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
