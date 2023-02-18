#shellcheck shell=ksh

bind ^L=clear-screen
set -o emacs
export TERM=xterm-256color

[ -f "$HOME/.ksh_completions" ] && . "$HOME/.ksh_completions"

_ps1_ret_code() {
  _ret=$?
  [ -n "${_ret##0}" ] && echo " [31m[[01m${_ret}[00m[31m][00m"
}

_ps1_git_branch() {
  git_status="$(git status 2>/dev/null | awk '/On branch/ {print $3}')"
  if [ "$git_status" != "" ]; then
    echo " ($git_status)" 
  fi
}

#shellcheck disable=SC2025
export PS1='[92m\u[0m@\h [92m\w[00m`_ps1_git_branch``_ps1_ret_code`\$ '

dotfiles() {
  #shellcheck disable=SC2068
  /usr/bin/git --git-dir "$HOME/.dotfiles/" --work-tree "$HOME" $@
}

pkgs() {
  if [ -z "$1" ]; then
    printf 'no package name specified\n'
    return 1
  fi
  /usr/bin/apt search --names-only "$1"
}

grabfile() {
  if [ -z "$1" ]; then
    printf 'no file name specified\n'
    return 1
  fi
  xclip -selection clipboard "$1"
}

snip() {
  cat - | xclip -selection clipboard -i
}

emacs() {
  command emacs -nw "$1"
}

dev_cd() {
  if [ -z "$1" ]; then
    cd "$HOME/dev" || return 1
    return 0
  fi
  if [ -z "$2" ]; then
    cd "$1" || return 1
    return 0
  fi
  cd "$1/$2" || return 1
}

devg() {
  dev_cd "$HOME/dev/github" "$1"
}
devs() {
  dev_cd "$HOME/dev/srht" "$1"
}

