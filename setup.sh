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
