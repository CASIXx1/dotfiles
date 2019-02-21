# rbenv
status --is-interactive; and source (rbenv init -|psub)

# peco
function fish_user_key_bindings
  bind \cf peco_select_history # Bind for peco select history to Ctrl+R
  bind \cr peco_select_ghq_repository # Bind for peco change directory to Ctrl+F
end
set -g fish_user_paths "/usr/local/opt/mysql@5.7/bin" $fish_user_paths
