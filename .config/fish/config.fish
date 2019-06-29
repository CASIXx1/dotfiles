# # rbenv
# status --is-interactive; and source (rbenv init -|psub)
#
# pyenv
set -gx PYENV_ROOT "$HOME/.pyenv"
set -x PATH $PATH "$PYENV_ROOT/bin"
status --is-interactive; and . (pyenv init - | psub)

function ghq_peco_repo
  set selected_repository (ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_repository" ]
    cd $selected_repository
    echo " $selected_repository "
    commandline -f repaint
  end
end

# fish key bindings
function fish_user_key_bindings
  bind \cg ghq_peco_repo
  # ghq を選択
  bind \cl peco_select_ghq_repository
  # gh-open
  bind \cx\cl peco_open_gh_repository
  # コマンド履歴を見る
  bind \cr peco_select_history
  # プロセスをキルする
  bind \cx\ck peco_kill
  # 最近見たディレクトリに移動
  bind \cx\cr peco_recentd

  # fzf
  bind \cx\cf '__fzf_find_file'
  bind \ctr '__fzf_reverse_isearch'
  bind \ex '__fzf_find_and_execute'
  bind \ed '__fzf_cd'
  bind \eD '__fzf_cd_with_hidden'
end

# mysql
set -g fish_user_paths "/usr/local/opt/mysql@5.7/bin" $fish_user_paths

# bundler
alias be='bundle exec'

# Aliases
alias g='git'
#compdef g=git
alias gst='git status'
#compdef _git gst=git-status
alias gd='git diff'
#compdef _git gd=git-diff
alias gdc='git diff --cached'
#compdef _git gdc=git-diff
alias gl='git pull'
#compdef _git gl=git-pull
alias gup='git pull --rebase'
#compdef _git gup=git-fetch
alias gp='git push'
#compdef _git gp=git-push
alias gd='git diff'

function gdv
  git diff -w $argv | view -
end

#compdef _git gdv=git-diff
# alias gc='git commit -v'
#compdef _git gc=git-commit
alias gc!='git commit -v --amend'
#compdef _git gc!=git-commit
alias gca='git commit -v -a'
#compdef _git gc=git-commit
alias gca!='git commit -v -a --amend'
#compdef _git gca!=git-commit
alias gcm='git commit -m'
#compdef _git gcmsg=git-commit
alias gc='git checkout'
alias gcb='git checkout -b'
#compdef _git gco=git-checkout
# alias gcm='git checkout master'
alias gr='git remote'
#compdef _git gr=git-remote
alias grv='git remote -v'
#compdef _git grv=git-remote
alias grmv='git remote rename'
#compdef _git grmv=git-remote
alias grrm='git remote remove'
#compdef _git grrm=git-remote
alias grset='git remote set-url'
#compdef _git grset=git-remote
alias grup='git remote update'
#compdef _git grset=git-remote
alias grbi='git rebase -i'
#compdef _git grbi=git-rebase
alias grbc='git rebase --continue'
#compdef _git grbc=git-rebase
alias grba='git rebase --abort'
#compdef _git grba=git-rebase
alias gb='git branch'
#compdef _git gb=git-branch
alias gba='git branch -a'
#compdef _git gba=git-branch
alias gcount='git shortlog -sn'
#compdef gcount=git
alias gcl='git config --list'
alias gcp='git cherry-pick'
#compdef _git gcp=git-cherry-pick
alias glg='git log --stat --max-count=10'
#compdef _git glg=git-log
alias glgg='git log --graph --max-count=10'
#compdef _git glgg=git-log
alias glgga='git log --graph --decorate --all'
#compdef _git glgga=git-log
alias glo='git log --oneline'
#compdef _git glo=git-log
alias gss='git status -s'
#compdef _git gss=git-status
alias ga='git add'
#compdef _git ga=git-add
alias gm='git merge'
#compdef _git gm=git-merge
alias grh='git reset HEAD'
alias grhh='git reset HEAD --hard'
alias gclean='git reset --hard; and git clean -dfx'
alias gwc='git whatchanged -p --abbrev-commit --pretty=medium'

#remove the gf alias
#alias gf='git ls-files | grep'

alias gpoat='git push origin --all; and git push origin --tags'
alias gmt='git mergetool --no-prompt'
#compdef _git gm=git-mergetool

alias gg='git gui citool'
alias gga='git gui citool --amend'
alias gk='gitk --all --branches'

alias gsts='git stash show --text'
alias gsta='git stash'
alias gstp='git stash pop'
alias gstd='git stash drop'

# Will cd into the top of the current repository
# or submodule.
alias grt='cd (git rev-parse --show-toplevel; or echo ".")'

# Git and svn mix
alias git-svn-dcommit-push='git svn dcommit; and git push github master:svntrunk'
#compdef git-svn-dcommit-push=git

alias gsr='git svn rebase'
alias gsd='git svn dcommit'
#
# Will return the current branch name
# Usage example: git pull origin $(current_branch)
#
function current_branch
  set ref (git symbolic-ref HEAD 2> /dev/null); or \
  set ref (git rev-parse --short HEAD 2> /dev/null); or return
  echo ref | sed s-refs/heads--
end

function current_repository
  set ref (git symbolic-ref HEAD 2> /dev/null); or \
  set ref (git rev-parse --short HEAD 2> /dev/null); or return
  echo (git remote -v | cut -d':' -f 2)
end

# these aliases take advantage of the previous function
alias ggpull='git pull origin (current_branch)'
#compdef ggpull=git
alias ggpur='git pull --rebase origin (current_branch)'
#compdef ggpur=git
alias ggpush='git push origin (current_branch)'
#compdef ggpush=git
alias ggpnp='git pull origin (current_branch); and git push origin (current_branch)'
#compdef ggpnp=git

# Pretty log messages
function _git_log_prettily
  if ! [ -z $1 ]; then
    git log --pretty=$1
  end
end

alias glp="_git_log_prettily"
#compdef _git glp=git-log

# Work In Progress (wip)
# These features allow to pause a branch development and switch to another one (wip)
# When you want to go back to work, just unwip it
#
# This function return a warning if the current branch is a wip
function work_in_progress
  if git log -n 1 | grep -q -c wip; then
    echo "WIP!!"
  end
end

# these alias commit and uncomit wip branches
alias gwip='git add -A; git ls-files --deleted -z | xargs -0 git rm; git commit -m "wip"'
alias gunwip='git log -n 1 | grep -q -c wip; and git reset HEAD~1'

function git
  if test -z "$argv"
    command git
    return
  end

  switch $argv[1]
    case push
      set -l head
      if not string join \n -- $argv | sed 1d | grep -E '^[^-]' >/dev/null
        and command git status -b --porcelain=v2 | grep -E 'upstream|head' | cut -d' ' -f3 | begin
          read head
          and not read -l upstream
        end
        and command git remote get-url origin >/dev/null
        and read -P"Set origin/$head as the upstream branch? [Y/n]: " -l ans
        and contains "$ans" y Y ''

        command git $argv -u origin $head
      else
        command git $argv
      end
    case '*'
      command git $argv
  end
end

# alacritty用の設定
# export LANG=ja_JP.UTF-8

# dot
set -gx DOT_REPO "https://github.com/CASIXx1/dotfiles.git"
set -gx DOT_DIR "$HOME/dotfiles"
set -gx DOT_SCR "$HOME/.dot"

# hub

# alias git='hub'

function __fish_hub_needs_command
  set cmd (commandline -opc)
  if [ (count $cmd) -eq 1 ]
    return 0
  else
    return 1
  end
end

function  __fish_hub_using_command
  set cmd (commandline -opc)
  if [ (count $cmd) -gt 1 ]
    if [ $argv[1] = $cmd[2] ]
      return 0
    end
  end
  return 1
end

complete -f -c hub -n '__fish_hub_needs_command' -a alias -d "show shell instructions for wrapping git"
complete -f -c hub -n '__fish_hub_needs_command' -a browse -d "browse the project on GitHub"
complete -f -c hub -n '__fish_hub_needs_command' -a compare -d "lookup commit in GitHub Status API"
complete -f -c hub -n '__fish_hub_needs_command' -a create -d "create new repo on GitHub for the current project"
complete -f -c hub -n '__fish_hub_needs_command' -a delete -d "delete a GitHub repo"
complete -f -c hub -n '__fish_hub_needs_command' -a fork -d "fork origin repo on GitHub"
complete -f -c hub -n '__fish_hub_needs_command' -a pull-request -d "open a pull request on GitHub"
complete -f -c hub -n '__fish_hub_needs_command' -a pr -d "list or checkout a GitHub release"
complete -f -c hub -n '__fish_hub_needs_command' -a issue -d "list or create a GitHub issue"
complete -f -c hub -n '__fish_hub_needs_command' -a release -d "list or create a GitHub release"
complete -f -c hub -n '__fish_hub_needs_command' -a ci-status -d "display GitHub Status information for a commit"
complete -f -c hub -n '__fish_hub_needs_command' -a sync -d "update local branches from upstream"

# alias
complete -f -c hub -n ' __fish_hub_using_command alias' -a 'bash zsh sh ksh csh fish' -d "output shell script suitable for eval"
# pull-request
complete -f -c hub -n ' __fish_hub_using_command pull-request' -s f -d "Skip the check for unpushed commits"
complete -f -c hub -n ' __fish_hub_using_command pull-request' -s -m -d "Set the pull request title and description separated by a blank line"
complete -f -c hub -n ' __fish_hub_using_command pull-request' -s F -d "Read the pull request title and description from <FILE>"
complete -f -c hub -n ' __fish_hub_using_command pull-request' -s o -d "Open the new pull request in a web browser"
complete -f -c hub -n ' __fish_hub_using_command pull-request' -l browse -d "Open the new pull request in a web browser"
complete -f -c hub -n ' __fish_hub_using_command pull-request' -s p -d "Push the current branch to <HEAD> before creating the pull request"
complete -f -c hub -n ' __fish_hub_using_command pull-request' -s b -d 'The base branch in "[OWNER:]BRANCH" format'
complete -f -c hub -n ' __fish_hub_using_command pull-request' -s h -d 'The head branch in "[OWNER:]BRANCH" format'
complete -f -c hub -n ' __fish_hub_using_command pull-request' -s a -d 'A comma-separated list of GitHub handles to assign to this pull request'
complete -f -c hub -n ' __fish_hub_using_command pull-request' -s M -d "The milestone name to add to this pull request. Passing the milestone number is deprecated."
complete -f -c hub -n ' __fish_hub_using_command pull-request' -s l -d "Add a comma-separated list of labels to this pull request"
# fork
complete -f -c hub -n ' __fish_hub_using_command fork' -l no-remote -d "Skip adding a git remote for the fork"
# browse
complete -f -c hub -n ' __fish_hub_using_command browse' -s u -d "Print the URL instead of opening it"
complete -f -c hub -n ' __fish_hub_using_command browse' -s c -d "Put the URL in clipboard instead of opening it"
complete -f -c hub -n ' __fish_hub_using_command browse' -a '-- commits' -d 'commits'
complete -f -c hub -n ' __fish_hub_using_command browse' -a '-- contributors' -d 'contributors'
complete -f -c hub -n ' __fish_hub_using_command browse' -a '-- issues' -d 'issues'
complete -f -c hub -n ' __fish_hub_using_command browse' -a '-- pulls' -d 'pull requests'
complete -f -c hub -n ' __fish_hub_using_command browse' -a '-- wiki' -d 'wiki'
# compare
complete -f -c hub -n ' __fish_hub_using_command compare' -s u -d 'Print the URL instead of opening it'
# create
complete -f -c hub -n ' __fish_hub_using_command create' -s o -d "Open the new repository in a web browser"
complete -f -c hub -n ' __fish_hub_using_command create' -l browse -d "Open the new repository in a web browser"
complete -f -c hub -n ' __fish_hub_using_command create' -s p -d "Create a private repository"
complete -f -c hub -n ' __fish_hub_using_command create' -s c -d "Put the URL of the new repository to clipboard instead of printing it."
complete -f -c hub -n ' __fish_hub_using_command create' -l copy -d "Put the URL of the new repository to clipboard instead of printing it."
# delete
complete -f -c hub -n ' __fish_hub_using_command delete' -s y -d "Skip the confirmation prompt"
complete -f -c hub -n ' __fish_hub_using_command delete' -l yes -d "Skip the confirmation prompt"
# ci-status
complete -f -c hub -n ' __fish_hub_using_command ci-status' -s v -d "Print detailed report of all status checks and their URLs"
