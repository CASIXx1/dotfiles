# brewがない可能性を考慮
xcode-select --install
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# fishが入っていない可能性を考慮
brew install fish

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
